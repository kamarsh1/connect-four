require_relative '../app/models/game'
require_relative '../app/models/make_a_move'

describe 'MakeAMove' do
  let(:some_name) { 'Pikachu' }
  let(:game) { Game.new }
  let(:humanPlayer) { HumanPlayer.new(some_name) }
  let(:computerPlayer) { ComputerPlayer.new(some_name) }

  describe '#make_a_move' do
    context 'when it is the HUMAN challengers turn' do
      before do
        current_player = humanPlayer
        game.is_player1 = false
        game.challenger = 'HUMAN'

        allow(current_player).to receive(:pick_a_column).and_return(3)
        allow(game).to receive(:valid_move?).and_return(true)
        allow(game).to receive(:place_chip_in_column)
        allow(game).to receive(:invalid_selection)
        game.make_a_move(current_player)
      end

      it 'calls pick a column for the HumanPlayer' do
        expect(humanPlayer).to have_received(:pick_a_column)
      end

      context "when it is player1's turn" do
        before do
          game.is_player1 = true
        end

        let(:pick_col_message) { "#{some_name} pick a column (1 through 7)\n" }

        it 'asks player1 to pick a column' do
          player1 = HumanPlayer.new(some_name)
          expect { game.make_a_move(player1) }.to output(pick_col_message).to_stdout
        end
      end

      context "when it is NOT player1's turn" do
        before do
          game.player1 = false
        end

        let(:pick_col_message) { "#{some_name} pick a column (1 through 7)\n" }

        it 'asks player2 to pick a column' do
          player2 = HumanPlayer.new(some_name)
          expect { game.make_a_move(player2) }.to output(pick_col_message).to_stdout
        end
      end
    end

    context 'when it is the COMPUTER challengers turn' do
      before do
        current_player = computerPlayer
        game.player1 = false
        game.challenger = 'COMPUTER'

        allow(current_player).to receive(:pick_a_column)
        allow(game).to receive(:valid_move?).and_return(true)
        allow(game).to receive(:place_chip_in_column)
        allow(game).to receive(:invalid_selection)
        game.make_a_move(current_player)
      end

      it 'calls pick a column for the ComputerPlayer' do
        expect(computerPlayer).to have_received(:pick_a_column)
      end
    end

    context 'when it is NOT a valid move' do
      context 'it loops until there IS a valid move' do
        before do
          current_player = humanPlayer
          game.player1 = false
          game.challenger = 'HUMAN'

          allow(current_player).to receive(:pick_a_column)
          allow(game).to receive(:valid_move?).and_return(false, false, false, false, true)
          allow(game).to receive(:place_chip_in_column)
          allow(game).to receive(:invalid_selection)
          game.make_a_move(current_player)
        end

        it 'calls pick a column until a valid move' do
          expect(humanPlayer).to have_received(:pick_a_column).exactly(5).times
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
        game.is_player1 = true
        game.game_board[5][column-1] = '...'
      end

      it 'places a RED chip in bottom-most empty row for chosen column' do
        game.place_chip_in_column(column)
        expect(game.game_board[5][column-1]).to eq('RED')
      end
    end

    context 'when NOT player1' do
      before do
        game.is_player1 = false
        game.game_board[5][column-1] = '...'
      end

      it 'places a BLK chip in bottom-most empty row for chosen column' do
        game.place_chip_in_column(column)
        expect(game.game_board[5][column-1]).to eq('BLK')
      end
    end

    context 'when lower rows for the chosen column are full' do
      before do
        game.is_player1 = true
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

