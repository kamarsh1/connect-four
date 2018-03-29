class ComputerPlayer
  def self.pick_a_column
    column = rand(1..7)
    puts "Computer picked #{column}"
    column
  end
end