class Game
  attr_accessor :game_board, :game_over, :player1, :valid_move, :column

  def initialize
    @game_board = Array.new(6){Array.new(7, '...')}
    @game_over = false
    @player1 = false
    # @column = column
  end

  def play
    # @player1 = false

    until @game_over
      @player1 = !@player1

      display_board

      column = pick_a_column
      valid_move?(column) ? place_chip_in_column : invalid_selection

      # take this out once game_over gets set in the right place
      @game_over = true
    end
  end

  def display_board
    @game_board.each { |row| p row }
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

  def place_chip_in_column
    puts 'Place chip in column'
  end

  def invalid_selection
    puts 'Invalid Selection'
  end
end

# game = Game.new
# game.play