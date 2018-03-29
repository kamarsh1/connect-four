class HumanPlayer
  def self.pick_a_column(player1)
    player = player1 ? 'PLAYER 1' : 'PLAYER 2'
    puts "#{player}, pick a column (1 through 7)"
    gets.chomp.to_i
  end
end