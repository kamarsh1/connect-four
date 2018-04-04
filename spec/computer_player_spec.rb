require_relative '../app/models/player'
require_relative '../app/models/computer_player'

describe 'ComputerPlayer' do
  let(:computerPlayer) { ComputerPlayer.new('some name', 'BLK') }

  describe 'pick_a_column' do
    it 'picks a random number between 1 and 7' do
      current_player = computerPlayer
      expect(computerPlayer.pick_a_column(current_player)).to be_between(1, 7)
    end
  end
end