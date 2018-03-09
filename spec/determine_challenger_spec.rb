require_relative '../game'
require_relative '../app/models/determine_challenger'

describe 'DetermineChallenger' do
  let(:game) { Game.new }

  describe '#determine_challenger' do
    context 'when an invalid challenger is input' do
      context 'it loops until the challenger is valid' do
        before do
          allow(game).to receive(:ask_who_is_playing)
          allow(game).to receive(:get_challenger)
          allow(game).to receive(:invalid_selection)
          allow(game).to receive(:valid_challenger?).and_return(false, false, true)
          game.determine_challenger
        end

        it 'gets who is playing' do
          expect(game).to have_received(:ask_who_is_playing).exactly(3).times
        end

        it 'prints invalid message' do
          expect(game).to have_received(:invalid_selection).exactly(2).times
        end

        it 'gets the challenger' do
          expect(game).to have_received(:get_challenger).exactly(3).times
        end

        it 'validates the input' do
          expect(game).to have_received(:valid_challenger?).exactly(3).times
        end
      end
    end
  end

  describe '#ask_who_is_playing' do
    let(:who_is_playing_message) { "\nWho is playing?\n\nEnter 1 to play against the computer.\nEnter 2 to play another person.\n" }

    it 'asks the user who they want to play against' do
      expect { game.ask_who_is_playing }.to output(who_is_playing_message).to_stdout
    end
  end

  describe '#get_challenger' do
    it 'gets a challenger from input' do
      allow(game).to receive(:gets).and_return('2')
      expect(game.get_challenger).to eq(2)
    end
  end

  describe '#valid_challenger?' do
    context 'when the challenger selected IS valid' do
      let(:challenger) { 2 }

      it 'returns true' do
        expect(game.valid_challenger?(challenger)).to eq(true)
      end
    end

    context 'when the challenger selected is NOT valid' do
      let(:challenger) { 4 }

      it 'returns false' do
        expect(game.valid_challenger?(challenger)).to eq(false)
      end
    end
  end
end
