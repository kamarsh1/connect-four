require_relative '../game'
require_relative '../app/models/make_a_move'

describe 'MakeAMove' do
  let(:game) { Game.new }

  describe '#make_a_move' do
    context 'when it is NOT a valid move' do
      context 'it loops until there IS a valid move' do
        before do
          allow(game).to receive(:pick_a_column)
          allow(game).to receive(:valid_move?).and_return(false, false, false, false, true)
          allow(game).to receive(:place_chip_in_column)
          allow(game).to receive(:invalid_selection)
          game.make_a_move
        end

        it 'calls pick a column until a valid move' do
          expect(game).to have_received(:pick_a_column).exactly(5).times
        end

        it 'checks if each move is valid' do
          expect(game).to have_received(:valid_move?).exactly(5).times
        end

        it 'calls invalid selection for each invalid move' do
          expect(game).to have_received(:invalid_selection).exactly(4).times
        end

        it 'places chip in column' do
          expect(game).to have_received(:place_chip_in_column).once
        end
      end
    end
  end

  describe '#pick_a_column' do
    context 'when HUMAN vs HUMAN' do
      before do
        game.challenger = 'HUMAN'
      end

      context 'when player1' do
        let(:pick_col_message) { "PLAYER 1, pick a column (1 through 7)\n" }

        before do
          game.player1 = true
        end

        it 'asks player1 to pick a column' do
          expect { game.pick_a_column }.to output(pick_col_message).to_stdout
        end

        it 'gets a number from input' do
          allow(game).to receive(:gets).and_return('5')
          expect(game.pick_a_column).to eq(5)
        end
      end

      context 'when NOT player1' do
        let(:pick_col_message) { "PLAYER 2, pick a column (1 through 7)\n" }

        before do
          game.player1 = false
        end

        it 'asks player2 to pick a column' do
          expect { game.pick_a_column }.to output(pick_col_message).to_stdout
        end

        it 'gets a number from input' do
          allow(game).to receive(:gets).and_return('3')
          expect(game.pick_a_column).to eq(3)
        end
      end
    end

    context 'when HUMAN vs COMPUTER' do
      before do
        game.challenger = 'COMPUTER'
      end

      context 'when player1' do
        let(:pick_col_message) { "PLAYER 1, pick a column (1 through 7)\n" }

        before do
          game.player1 = true
        end

        it 'asks player1 to pick a column' do
          expect { game.pick_a_column }.to output(pick_col_message).to_stdout
        end

        it 'gets a number from input' do
          allow(game).to receive(:gets).and_return('6')
          expect(game.pick_a_column).to eq(6)
        end
      end

      context 'when NOT player1' do
        before do
          game.player1 = false
          allow(game).to receive(:random_number).and_return(1)
        end

        it 'prints a message' do
          expect { game.pick_a_column }.to output("Computer picked 1\n").to_stdout
        end
      end
    end
  end

  describe '#random_number' do
    it 'picks a random number between 1 and 7' do
      expect(game.random_number).to be_between(1, 7)
    end
  end

  describe '#valid_move?' do
    context 'when column chosen is a valid column' do
      let(:column) { 4 }

      context 'and the column is NOT full' do
        before do
          game.game_board[5][column-1] = 'BLK'
          game.game_board[4][column-1] = 'BLK'
          game.game_board[3][column-1] = 'BLK'
        end

        it 'the move IS valid' do
          expect(game.valid_move?(column)).to eq(true)
        end
      end
    end

    context 'when column chosen IS a valid column' do
      let(:column) { 7 }

      context 'but the column is full' do
        before do
          game.game_board[5][column-1] = 'BLK'
          game.game_board[4][column-1] = 'BLK'
          game.game_board[3][column-1] = 'BLK'
          game.game_board[2][column-1] = 'RED'
          game.game_board[1][column-1] = 'RED'
          game.game_board[0][column-1] = 'RED'
        end

        it 'the move is NOT valid' do
          expect(game.valid_move?(column)).to eq(false)
        end
      end
    end

    context 'when column chosen is NOT valid' do
      let(:column) { 12 }

      it 'the move is NOT valid' do
        expect(game.valid_move?(column)).to eq(false)
      end
    end
  end

  describe '#place_chip_in_column' do
    let(:column) { 1 }

    context 'when player1' do
      before do
        game.player1 = true
        game.game_board[5][column-1] = '...'
      end

      it 'places a RED chip in bottom-most empty row for chosen column' do
        game.place_chip_in_column(column)
        expect(game.game_board[5][column-1]).to eq('RED')
      end
    end

    context 'when NOT player1' do
      before do
        game.player1 = false
        game.game_board[5][column-1] = '...'
      end

      it 'places a BLK chip in bottom-most empty row for chosen column' do
        game.place_chip_in_column(column)
        expect(game.game_board[5][column-1]).to eq('BLK')
      end
    end

    context 'when lower rows for the chosen column are full' do
      before do
        game.player1 = true
        game.game_board[5][column-1] = 'BLK'
        game.game_board[4][column-1] = 'BLK'
        game.game_board[3][column-1] = 'BLK'
      end

      it 'puts chip in next available row for the chosen column' do
        game.place_chip_in_column(column)
        expect(game.game_board[5][column-1]).not_to eq('RED')
        expect(game.game_board[4][column-1]).not_to eq('RED')
        expect(game.game_board[3][column-1]).not_to eq('RED')
        expect(game.game_board[2][column-1]).to eq('RED')
      end
    end
  end
end

