require_relative '../app/models/game'

describe 'Game' do
  let(:game) { Game.new }

  describe '#initialize' do
    let(:initial_board) { [%w[... ... ... ... ... ... ...], %w[... ... ... ... ... ... ...], %w[... ... ... ... ... ... ...], %w[... ... ... ... ... ... ...], %w[... ... ... ... ... ... ...], %w[... ... ... ... ... ... ...]] }
    it 'creates the game board' do
      expect(game.game_board).to eq(initial_board)
    end

    it 'sets boolean for is_player1' do
      expect(game.is_player1).to eq(false)
    end
  end

  describe '#play' do
    before do
      allow(game).to receive(:determine_challenger)
      # toggle player no longer returns a boolean.
      # it returns the current player which is an instance based
      # whatever determine challenger returns
      allow(game).to receive(:toggle_player).and_return(true)
      allow(game).to receive(:display_board)
      allow(game).to receive(:make_a_move)
      allow(game).to receive(:win_or_tie?).and_return(false, false, false, true)
      game.play
    end

    context 'when the game first begins' do
      it 'determines the challenger' do
        expect(game).to have_received(:determine_challenger)
      end
    end

    context 'when the game is NOT over' do
      context 'loops until the game IS over' do
        it 'toggles the player' do
          expect(game).to have_received(:toggle_player).exactly(4).times
        end

        it 'displays the board' do
          expect(game).to have_received(:display_board).exactly(5).times
        end

        it 'makes a move' do
          expect(game).to have_received(:make_a_move).exactly(4).times
        end

        it 'checks for game over' do
          expect(game).to have_received(:win_or_tie?).exactly(4).times
        end
      end
    end
  end

  describe '#toggle player' do
    let(:is_player1) { false }

    it 'toggles the boolean assigned to is_player1' do
      game.toggle_player('whatever', 'whatever')
      expect(game.is_player1).to eq(true)
    end
  end

  describe '#display_board' do
    let(:board) {"\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n\n"}

    it 'prints out the game board' do
      expect { game.display_board }.to output(board).to_stdout
    end
  end

  describe '#invalid_selection' do
    let(:invalid_message) { "Invalid Selection\n" }

    it 'prints a message' do
      expect { game.invalid_selection }.to output(invalid_message).to_stdout
    end
  end
end
