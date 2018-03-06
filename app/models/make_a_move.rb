module MakeAMove
  def make_a_move
    begin
      column = pick_a_column
      valid_move = valid_move?(column)
      valid_move ? place_chip_in_column(column) : invalid_selection
    end until valid_move
  end

  def pick_a_column
    player = @player1 ? 'PLAYER 1' : 'PLAYER 2'

    if @challenger == 'HUMAN' || @player1
      puts "#{player}, pick a column (1 through 7)"
      gets.chomp.to_i
    else
      column = random_number
      puts "Computer picked #{column}"
      column
    end
  end

  def random_number
    rand(1..7)
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