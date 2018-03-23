require_relative '../models/player'

module MakeAMove
  def make_a_move
    begin
      column = Player.pick_a_column(@player1, @challenger)
      valid_move = valid_move?(column)
      valid_move ? place_chip_in_column(column) : invalid_selection
    end until valid_move
  end

  def valid_move?(column)
    column.between?(1,7) && @game_board[0][column-1] == '...'
  end

  def place_chip_in_column(column)
    5.downto(0).each do |row|
      if @game_board[row][column-1] == '...'
        @game_board[row][column-1] = @player1 ? 'RED' : 'BLK'
        break
      end
    end
  end
end