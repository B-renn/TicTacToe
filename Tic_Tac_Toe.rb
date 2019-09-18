class TicTacToe
    @@move_counter
    def initialize
        @board = Board.new
        @player_1 = Player.new("Player_1","X",@board)
        @player_2 = Player.new("Player_2","O",@board)
        @current_player = @player_1
        @@move_counter = 0
    end
    def play 
        @player_1.change_name
        @player_2.change_name
        print "Hello #{@player_1.name}(#{@player_1.piece}) and #{@player_2.name}(#{@player_2.piece}) - Let's play TicTacToe\n"
        @board.new_board
        loop do
            print "Your turn #{@current_player.name} (#{@current_player.piece})\n"
            @current_player.play_round
            break if game_won || draw
            switch_player
        end
    end

    def switch_player
        if @current_player == @player_1
            @current_player = @player_2
        elsif @current_player == @player_2
            @current_player = @player_1
        end
    end
    def game_won
       if @board.game_won(@current_player.piece) == true
            print "Congratulations #{@current_player.name}! You Won !\n"
            true
       else
            false 
       end
    end

    def draw
        @@move_counter += 1
        if @@move_counter == 9
            print "Draw! Game over\n"
            true
        else
            false
        end
    end
end

class Player
    attr_accessor :name, :piece
    def initialize(name,piece,board)
        @name = name
        @piece = piece
        @board = board
    end

    def change_name 
        puts "Enter player name:"
        name = gets.chomp
        @name = name
    end
    def play_round
        puts "Enter coordinates of move (row,column)"
        move_input = gets.chomp
        input_array = move_input.split(",").to_a
        loop do
            break if check_input?(input_array[0].to_i,input_array[1].to_i)
            print "invalid input! Enter new move:\n"
            move_input = gets.chomp
            input_array = move_input.split(",").to_a
        end
        @board.update(input_array[0].to_i,input_array[1].to_i,@piece)
    end

    def check_input?(row_input,column_input)
        return true if (row_input > 0 && row_input <= 3) && (column_input > 0 && column_input <= 3)
        false
    end
end

class Board
    def initialize
        @board = Array.new(3){Array.new(3)}
    end

    def new_board
        3.times do |row|
            3.times {|column| print @board[row][column] = "-" if @board[row][column].nil? == true}
            print "\n"
        end
        print "\n"
    end

    def update(row_input,column_input,piece)
        if @board[row_input - 1][column_input - 1] != "-"
            print "That spot is already taken. Enter new move\n"
            move_input = gets.chomp
            input_array = move_input.split(",").to_a
            update(input_array[0].to_i,input_array[1].to_i,piece)
        else
            3.times do |row|
                3.times do |column|
                    if row == row_input - 1 && column == column_input - 1
                        @board[row][column] = piece
                        print @board[row][column].to_s

                    else
                        print @board[row][column].to_s
                    end
                end
                print "\n"
            end
        end
    end

    def game_won(piece)
        board_transpose = @board.transpose
        3.times do |i|
            return true if @board[i].all? {|index| index == piece} || board_transpose[i].all? {|index| index == piece}     
        end
        if @board[1][1] != "-"
            return true if @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] || @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]
        end
    end
end

game = TicTacToe.new
game.play
