module DetermineChallenger
  def determine_challenger
    begin
      ask_who_is_playing
      challenger = get_challenger
      valid_challenger = valid_challenger?(challenger)
      invalid_selection unless valid_challenger
    end until valid_challenger
    challenger == 1 ? 'COMPUTER' : 'HUMAN'
  end

  def ask_who_is_playing
    1.times { puts }
    puts 'Who is playing?'
    1.times { puts }
    puts 'Enter 1 to play against the computer.'
    puts 'Enter 2 to play another person.'
  end

  def get_challenger
    gets.chomp.to_i
  end

  def valid_challenger?(challenger)
    challenger.between?(1,2)
  end
end