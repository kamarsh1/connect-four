require_relative '../models/player'
require_relative '../../app/models/computer_player'
require_relative '../../app/models/human_player'

module MakeAMove
  def make_a_move
    begin
      if challenger === 'HUMAN' || player1
        puts "#{player1 ? 'PLAYER 1' : 'PLAYER 2'}, pick a column (1 through 7)"
        column = HumanPlayer.pick_a_column
      else
        column = ComputerPlayer.pick_a_column
        puts "Computer picked #{column}"
      end
      valid_move = valid_move?(column)
      valid_move ? place_chip_in_column(column) : invalid_selection
    end until valid_move
  end

  def valid_move?(column)
    column.between?(1,7) && game_board[0][column-1] == '...'
  end

  def place_chip_in_column(column)
    5.downto(0).each do |row|
      if game_board[row][column-1] == '...'
        game_board[row][column-1] = player1 ? 'RED' : 'BLK'
        break
      end
    end
  end
end
