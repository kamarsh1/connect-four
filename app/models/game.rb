require_relative 'make_a_move'
require_relative 'determine_challenger'
require_relative 'win_or_tie'

class Game
  include MakeAMove, DetermineChallenger, WinOrTie
  attr_accessor :game_board, :game_over, :player1, :challenger

  def initialize
    @game_board = Array.new(6){Array.new(7, '...')}
    @game_over = false
    @player1 = false
  end

  def play
    @challenger = determine_challenger

    begin
      toggle_player
      display_board
      make_a_move
      game_over = win_or_tie?
    end until game_over
    display_board
  end

  def toggle_player
    @player1 = !@player1
  end

  def display_board
    1.times { puts }
    @game_board.each { |row| p row }
    1.times { puts }
  end

  def invalid_selection
    puts 'Invalid Selection'
  end
end
