require_relative '../app/models/player'
require_relative '../app/models/human_player'

describe 'HumanPlayer' do
  let(:some_name) { 'Charmander' }
  let(:color) { 'Orange' }
  let(:humanPlayer) { HumanPlayer.new(some_name, color) }
  let(:pick_col_message) { "#{some_name} pick a column (1 through 7)\n" }

  describe 'pick_a_column' do
    before do
      allow(humanPlayer).to receive(:gets).and_return('2')
    end

    it 'asks the player to pick a column' do
      current_player = humanPlayer
      expect { current_player.pick_a_column(current_player) }.to output(pick_col_message).to_stdout
    end

    it 'gets a number from input' do
      current_player = humanPlayer
      expect(current_player.pick_a_column(current_player)).to eq(2)
    end
  end
end
