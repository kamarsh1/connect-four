class ComputerPlayer < Player
  def pick_a_column
    column = rand(1..7)
    puts "Computer picked #{column}"
    column
  end
end
