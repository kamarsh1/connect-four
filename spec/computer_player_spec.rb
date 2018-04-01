require_relative '../app/models/computer_player'

describe 'ComputerPlayer' do
  let(:computerPlayer) { ComputerPlayer.new }

  describe 'pick_a_column' do
    it 'picks a random number between 1 and 7' do
      expect(computerPlayer.pick_a_column).to be_between(1, 7)
    end
  end
end