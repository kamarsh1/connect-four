class Game
  attr_accessor :game_board, :game_over, :player1

  def initialize
    @game_board = Array.new(6){Array.new(7, '...')}
    @game_over = false
    @player1 = false
  end

  def play
    begin
      @player1 = !@player1
      display_board
      make_a_move
      game_over = win_or_tie?
    end until game_over
  end

  def make_a_move
    begin
      column = pick_a_column
      valid_move = valid_move?(column)
      valid_move ? place_chip_in_column(column) : invalid_selection
      display_board
    end until valid_move
  end

  def display_board
    1.times { puts }
    @game_board.each { |row| p row }
    1.times { puts }
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

  def place_chip_in_column(column)
    5.downto(0).each do |row|
      if @game_board[row][column-1] == '...'
        @player1 ? @game_board[row][column-1] = 'RED' : @game_board[row][column-1] = 'BLK'
        break
      end
    end
  end

  def invalid_selection
    puts 'Invalid Selection'
  end

  def win_or_tie?
    tie = check_for_tie
    if tie
      print_tie_message
    end
    tie
  end

  def check_for_tie
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

# game = Game.new
# game.play