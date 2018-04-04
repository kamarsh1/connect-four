class ComputerPlayer < Player
  def pick_a_column(current_player)
    column = rand(1..7)
    puts "#{current_player.name} picked #{column}"
    column
  end
end
