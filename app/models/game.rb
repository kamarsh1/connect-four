require_relative 'make_a_move'
require_relative 'determine_challenger'
require_relative 'win_or_tie'

class Game
  include MakeAMove, DetermineChallenger, WinOrTie
  attr_accessor :game_board, :is_player1, :challenger, :player1, :player2

  def initialize
    @game_board = Array.new(6){Array.new(7, '...')}
    @is_player1 = false
  end

  def play
    game_over = false
    challenger = determine_challenger
    challenger == 'COMPUTER' ? player2 = ComputerPlayer.new : player2 = HumanPlayer.new
    player1 = HumanPlayer.new

    begin
      current_player = toggle_player(player1, player2)
      display_board
      make_a_move(current_player)
      game_over = win_or_tie?
    end until game_over
    display_board
  end

  def toggle_player(player1, player2)
    @is_player1 = !@is_player1
    @is_player1 ? player1 : player2
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
