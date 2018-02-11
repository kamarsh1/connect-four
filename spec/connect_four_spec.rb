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
        allow(game).to receive(:pick_a_column).and_return(3)
      end

      it 'toggles player1' do
        player1_toggle = !game.player1
        game.play
        expect(game.player1).to eq(player1_toggle)
      end

      it 'displays the board' do
        game.play
        expect(game).to have_received(:display_board)
      end

      it 'picks a column' do
        game.play
        expect(game).to have_received(:pick_a_column)
      end

      describe 'when it IS a valid move' do
        before do
          allow(game).to receive(:valid_move?).and_return(true)
          allow(game).to receive(:place_chip_in_column)
          game.play
        end
        it 'places chip in column' do
          expect(game).to have_received(:place_chip_in_column)
        end
      end

      describe 'when it is NOT a valid move' do
        before do
          allow(game).to receive(:valid_move?).and_return(false)
          allow(game).to receive(:invalid_selection)
          game.play
        end
        it 'displays invalid selection' do
          expect(game).to have_received(:invalid_selection)
        end
      end
    end
  end

  describe '#display_board' do
    let(:board) {"[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n"}

    it 'prints out the game board' do
      expect { game.display_board }.to output(board).to_stdout
    end
  end

  describe '#pick_a_column' do
    context 'when player1' do
      before do
        game.player1 = true
      end

      it 'asks player to pick a column' do
        expect { game.pick_a_column }.to output("Pick a column (1 through 7)\n").to_stdout
      end

      it 'gets a number from input' do
        allow(game).to receive(:gets).and_return('3')
        expect(game.pick_a_column).to eq(3)
      end
    end

    context 'when NOT player1' do
      before do
        game.player1 = false
      end

      it 'picks a random number between 1 and 7' do
        expect(game.pick_a_column).to be_between(1, 7)
      end

      # it 'prints a message' do       #### figure this out!!!
      #   expect { game.pick_a_column }.to output("Computer picked").to_stdout
      # end
    end
  end

  describe '#valid_move?' do
    context 'when valid move' do
      let(:column) { 4 }
      it 'returns true when IS a valid move' do
        expect(game.valid_move?(column)).to eq(true)
      end
    end

    context 'when NOT valid move' do
      let(:column) { 12 }
      it 'returns false when NOT a valid move' do
        expect(game.valid_move?(column)).to eq(false)
      end
    end

    #### Need to set up a context where the column is valid but the column is full
  end

  describe '#invalid_selection' do
    it 'prints a message' do
      expect { game.invalid_selection }.to output("Invalid Selection\n").to_stdout
    end
  end
end
