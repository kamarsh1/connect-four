require_relative '../app/models/game'

describe 'Player' do
  let(:game) { Game.new }

  describe 'pick_a_column' do
    context 'when HUMAN vs HUMAN' do
      before do
        game.challenger = 'HUMAN'
      end

      context 'when player1' do
        let(:pick_col_message) { "PLAYER 1, pick a column (1 through 7)\n" }
        let(:player1) { true }

        it 'asks player1 to pick a column' do
          expect { Player.pick_a_column(player1, game.challenger) }.to output(pick_col_message).to_stdout
        end


        it 'gets a number from input' do
          allow(Player).to receive(:gets).and_return('5')
          expect(Player.pick_a_column(player1, game.challenger)).to eq(5)
        end
      end

      context 'when NOT player1' do
        let(:pick_col_message) { "PLAYER 2, pick a column (1 through 7)\n" }
        let(:player1) { false }

        it 'asks player2 to pick a column' do
          expect { Player.pick_a_column(player1, game.challenger) }.to output(pick_col_message).to_stdout
        end

        it 'gets a number from input' do
          allow(Player).to receive(:gets).and_return('3')
          expect(Player.pick_a_column(player1, game.challenger)).to eq(3)
        end
      end
    end

    context 'when HUMAN vs COMPUTER' do
      before do
        game.challenger = 'COMPUTER'
      end

      context 'when player1' do
        let(:pick_col_message) { "PLAYER 1, pick a column (1 through 7)\n" }
        let(:player1) { true }

        it 'asks player1 to pick a column' do
          expect { Player.pick_a_column(player1, game.challenger) }.to output(pick_col_message).to_stdout
        end

        it 'gets a number from input' do
          allow(Player).to receive(:gets).and_return('6')
          expect(Player.pick_a_column(player1, game.challenger)).to eq(6)
        end
      end

      context 'when NOT player1' do
        let(:player1) { false }

        before do
          allow(Player).to receive(:random_number).and_return(1)
        end

        it 'prints a message' do
          expect { Player.pick_a_column(player1, game.challenger) }.to output("Computer picked 1\n").to_stdout
        end
      end
    end
  end
end
