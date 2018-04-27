require_relative '../app/models/game'
require_relative '../app/services/make_a_move'

describe 'MakeAMove' do
  let(:some_name) { 'Pikachu' }
  let(:some_color) { 'RED' }
  let(:game) { Game.new }
  let(:humanPlayer) { HumanPlayer.new(some_name, some_color) }
  let(:computerPlayer) { ComputerPlayer.new(some_name, some_color) }

  describe '#make_a_move' do
    context 'when it is a HUMANs turn' do
      before do
        current_player = humanPlayer
        allow(current_player).to receive(:pick_a_column).with(current_player).and_return(3)
        game.make_a_move(current_player)
      end

      context 'when it is player 1s turn' do
        before do
          game.is_player1 = true
        end

        it 'calls pick a column for the HumanPlayer' do
          expect(humanPlayer).to have_received(:pick_a_column)
        end
      end

      context 'when it is player 2s turn' do
        before do
          game.player1 = false
        end

        it 'calls pick a column for the HumanPlayer' do
          expect(humanPlayer).to have_received(:pick_a_column)
        end
      end
    end

    context 'when it is the COMPUTERs turn' do
      before do
        current_player = computerPlayer
        game.player1 = false

        allow(current_player).to receive(:pick_a_column).with(current_player).and_return(4)
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
      let(:humanPlayer) { HumanPlayer.new('Bob', 'RED') }

      before do
        game.is_player1 = true
        game.game_board[5][column-1] = '...'
      end

      it 'places the current players color chip in bottom-most empty row for chosen column' do
        current_player = humanPlayer
        game.place_chip_in_column(column, current_player)
        expect(game.game_board[5][column-1]).to eq('RED')
      end
    end

    context 'when player 2' do
      let(:humanPlayer) { HumanPlayer.new('Bob', 'yellow') }

      before do
        game.is_player1 = false
        game.game_board[5][column-1] = '...'
      end

      it 'places the current players color chip in bottom-most empty row for chosen column' do
        current_player = humanPlayer
        game.place_chip_in_column(column, current_player)
        expect(game.game_board[5][column-1]).to eq('yellow')
      end
    end

    context 'when lower rows for the chosen column are full' do
      let(:humanPlayer) { HumanPlayer.new('Bob', 'magenta') }

      before do
        game.is_player1 = true
        game.game_board[5][column-1] = 'BLK'
        game.game_board[4][column-1] = 'BLK'
        game.game_board[3][column-1] = 'BLK'
      end

      it 'puts chip in next available row for the chosen column' do
        current_player = humanPlayer
        game.place_chip_in_column(column, current_player)
        expect(game.game_board[5][column-1]).not_to eq('magenta')
        expect(game.game_board[4][column-1]).not_to eq('magenta')
        expect(game.game_board[3][column-1]).not_to eq('magenta')
        expect(game.game_board[2][column-1]).to eq('magenta')
      end
    end
  end
end

