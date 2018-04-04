class HumanPlayer < Player
  def pick_a_column(current_player)
    puts "#{current_player.name} pick a column (1 through 7)"
    gets.chomp.to_i
  end
end
