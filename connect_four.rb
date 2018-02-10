class Game
  attr_accessor :game_board, :game_over, :player1, :valid_move, :column

  def initialize
    @game_board = Array.new(6){Array.new(7, '...')}
    @game_over = false
    @player1 = false
    @column = column
  end

  def play
    until @game_over
      @player1 = !@player1
      @valid_move = false
      display_board

      pick_a_column

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
      @column = gets.chomp.to_i
    else
      @column = rand(1..7)
      puts "Computer picked #{@column}"
    end
  end
end

game = Game.new
game.play