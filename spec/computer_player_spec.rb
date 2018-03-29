require_relative '../app/models/computer_player'

describe 'ComputerPlayer' do
  describe 'pick_a_column' do
    it 'picks a random number between 1 and 7' do
      expect(ComputerPlayer.pick_a_column).to be_between(1, 7)
    end
  end
end