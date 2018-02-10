require_relative '../connect_four'

describe 'Game' do
  let(:game) { Game.new }

  describe '#initialize' do
    it 'creates the game board' do
      expect(game.game_board).to eq([["...", "...", "...", "...", "...", "...", "..."], ["...", "...", "...", "...", "...", "...", "..."], ["...", "...", "...", "...", "...", "...", "..."], ["...", "...", "...", "...", "...", "...", "..."], ["...", "...", "...", "...", "...", "...", "..."], ["...", "...", "...", "...", "...", "...", "..."]])
    end

    it 'sets game over flag' do
      expect(game.game_over).to eq(false)
    end

    it 'sets player1' do
      expect(game.player1).to eq(false)
    end
  end

  describe '#play' do
    describe 'until the game is over' do
      before do
        allow(game).to receive(:display_board)
      end

      it 'toggles player1' do
        player1_toggle = !game.player1
        game.play
        expect(game.player1).to eq(player1_toggle)
      end

      it 'sets valid move' do
        game.play
        expect(game.valid_move).to eq(false)
      end

      it 'displays the board' do
        game.play
        expect(game).to have_received(:display_board)
      end
    end
  end

  describe '#display_board' do
    let(:board) {"[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n"}

    it 'prints out the game board' do
      expect { game.display_board }.to output(board).to_stdout
    end
  end
end
