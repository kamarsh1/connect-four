class Player
  def self.pick_a_column(player1, challenger)
    player = player1 ? 'PLAYER 1' : 'PLAYER 2'

    if challenger === 'HUMAN' || player1
      puts "#{player}, pick a column (1 through 7)"
      gets.chomp.to_i
    else
      column = random_number
      puts "Computer picked #{column}"
      column
    end
  end

  def self.random_number
    rand(1..7)
  end
end