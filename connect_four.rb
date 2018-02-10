class Game
  # attr_accessor :column
  attr_accessor :game_board, :game_over, :player1, :valid_move

  def initialize
    @game_board = Array.new(6){Array.new(7, '...')}
    @game_over = false
    @player1 = false
  #   @column = column
  end

  def play
    # until @game_over
    @player1 = !@player1
    @valid_move = false
    display_board
  end

  def display_board
    @game_board.each { |row| p row }
  end
end

game = Game.new
game.play