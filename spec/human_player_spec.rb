require_relative '../app/models/player'
require_relative '../app/models/human_player'

describe 'HumanPlayer' do
  let(:humanPlayer) { HumanPlayer.new('some name') }

  describe 'pick_a_column' do
    before do
      allow(humanPlayer).to receive(:gets).and_return('2')
    end

    it 'gets a number from input' do
      expect(humanPlayer.pick_a_column).to eq(2)
    end
  end
end
