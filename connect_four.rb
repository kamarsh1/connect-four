class Game
  attr_accessor :game_board, :game_over, :player1

  def initialize
    @game_board = Array.new(6){Array.new(7, '...')}
    @game_over = false
    @player1 = false
  end

  def play
    until @game_over
      @player1 = !@player1
      display_board

      begin
        column = pick_a_column
        valid_move = valid_move?(column)
        valid_move ? place_chip_in_column(column) : invalid_selection
        display_board
      end until valid_move

      # take this out once game_over gets set in the right place
      @game_over = true
    end
  end

  def display_board
    1.times { puts }
    @game_board.each { |row| p row }
    1.times { puts }
  end

  def pick_a_column
    if @player1
      puts 'Pick a column (1 through 7)'
      gets.chomp.to_i
    else
      column = rand(1..7)
      puts "Computer picked #{column}"
      column
    end
  end

  def valid_move?(column)
    column.between?(1,7) && @game_board[0][column-1] == '...'
  end

  def place_chip_in_column(column)
    5.downto(0).each do |row|
      if @game_board[row][column-1] == '...'
        @player1 ? @game_board[row][column-1] = 'RED' : @game_board[row][column-1] = 'BLK'
        break
      end
    end
  end

  def invalid_selection
    puts 'Invalid Selection'
  end
end

# game = Game.new
# game.play