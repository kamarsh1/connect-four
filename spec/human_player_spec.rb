require_relative '../app/models/human_player'

describe 'HumanPlayer' do
  describe 'pick_a_column' do
    context 'when player1' do
      let(:pick_col_message) { "PLAYER 1, pick a column (1 through 7)\n" }
      let(:player1) { true }

      it 'asks player1 to pick a column' do
        expect { HumanPlayer.pick_a_column(player1) }.to output(pick_col_message).to_stdout
      end


      it 'gets a number from input' do
        allow(HumanPlayer).to receive(:gets).and_return('5')
        expect(HumanPlayer.pick_a_column(player1)).to eq(5)
      end
    end

    context 'when NOT player1' do
      let(:pick_col_message) { "PLAYER 2, pick a column (1 through 7)\n" }
      let(:player1) { false }

      it 'asks player2 to pick a column' do
        expect { HumanPlayer.pick_a_column(player1) }.to output(pick_col_message).to_stdout
      end

      it 'gets a number from input' do
        allow(HumanPlayer).to receive(:gets).and_return('3')
        expect(HumanPlayer.pick_a_column(player1)).to eq(3)
      end
    end
  end
end