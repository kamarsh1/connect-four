module WinOrTie
  def win_or_tie?
    win = check_for_win
    if win
      print_win_message
      return true
    end

    tie = check_for_tie
    if tie
      print_tie_message
      return true
    end
    false
  end

  def check_for_win
    if horizontal_win?
      return true
    end

    if vertical_win?
      return true
    end

    if diagonal_win_up?
      return true
    end

    if diagonal_win_down?
      return true
    end
    false
  end

  def horizontal_win?
    5.downto(0).each do |row|
      (0..3).each do |column|
        if @game_board[row][column] != '...' &&
            @game_board[row][column] == @game_board[row][column+1] &&
            @game_board[row][column] == @game_board[row][column+2] &&
            @game_board[row][column] == @game_board[row][column+3]
          return true
        end
      end
    end
    false
  end

  def vertical_win?
    (0..6).each do |column|
      5.downto(3).each do |row|
        if @game_board[row][column] != '...' &&
            @game_board[row][column] == @game_board[row-1][column] &&
            @game_board[row][column] == @game_board[row-2][column] &&
            @game_board[row][column] == @game_board[row-3][column]
          return true
        end
      end
    end
    false
  end

  def diagonal_win_up?
    (0..3).each do |col|
      5.downto(3).each do |row|
        if @game_board[row][col] != '...' &&
            @game_board[row][col] == @game_board[row-1][col+1] &&
            @game_board[row][col] == @game_board[row-2][col+2] &&
            @game_board[row][col] == @game_board[row-3][col+3]
          return true
        end
      end
    end
    false
  end

  def diagonal_win_down?
    (0..3).each do |col|
      (0..2).each do |row|
        if @game_board[row][col] != '...' &&
            @game_board[row][col] == @game_board[row+1][col+1] &&
            @game_board[row][col] == @game_board[row+2][col+2] &&
            @game_board[row][col] == @game_board[row+3][col+3]
          return true
        end
      end
    end
    false
  end

  def print_win_message
    @player1 ? player = 'RED' : player = 'BLK'
    1.times { puts }
    puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    puts "!!!!!!!!!!!!!!!!!!! #{player} WINS !!!!!!!!!!!!!!!!!!!!"
    puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    1.times { puts }
  end

  def check_for_tie
    (0..6).each do |i|
      if @game_board[0][i] == '...'
        return false
      end
    end
    true
  end

  def print_tie_message
    1.times { puts }
    puts '*************************************************'
    puts "****************** It's a TIE! ******************"
    puts '*************************************************'
    1.times { puts }
  end
end