require_relative '../app/models/human_player'

describe 'HumanPlayer' do
  describe 'pick_a_column' do
    it 'gets a number from input' do
      allow(HumanPlayer).to receive(:gets).and_return('2')
      expect(HumanPlayer.pick_a_column).to eq(2)
    end
  end
end
