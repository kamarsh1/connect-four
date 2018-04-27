require_relative '../models/player'
require_relative '../../app/models/computer_player'
require_relative '../../app/models/human_player'

  module MakeAMove
    def make_a_move(current_player)
      begin
        column = current_player.pick_a_column(current_player)
        valid_move = valid_move?(column)
        valid_move ? place_chip_in_column(column, current_player) : invalid_selection
      end until valid_move
    end

    def valid_move?(column)
      column.between?(1,7) && game_board[0][column-1] == '...'
    end

    def place_chip_in_column(column, current_player)
      5.downto(0).each do |row|
        if game_board[row][column-1] == '...'
          game_board[row][column-1] = current_player.color
          break
        end
      end
    end
  end

