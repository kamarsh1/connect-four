require_relative '../game'

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
    context 'when the game is NOT over' do
      context 'loops until the game IS over' do
        before do
          allow(game).to receive(:toggle_player).and_return(true)
          allow(game).to receive(:display_board)
          allow(game).to receive(:make_a_move)
          allow(game).to receive(:win_or_tie?).and_return(false, false, false, true)
          game.play
        end

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
    let(:player1) { false }

    it 'toggles the boolean assigned to player1' do
      game.toggle_player
      expect(game.player1).to eq(true)
    end
  end

  describe '#display_board' do
    let(:board) {"\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n\n"}

    it 'prints out the game board' do
      expect { game.display_board }.to output(board).to_stdout
    end
  end

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
    context 'when player1' do
      before do
        game.player1 = true
      end

      it 'asks player1 to pick a column' do
        expect { game.pick_a_column }.to output("Player 1, pick a column (1 through 7)\n").to_stdout
      end

      it 'gets a number from input' do
        allow(game).to receive(:gets).and_return('5')
        expect(game.pick_a_column).to eq(5)
      end
    end

    context 'when NOT player1' do
      before do
        game.player1 = false
      end

      it 'asks player2 to pick a column' do
        expect { game.pick_a_column }.to output("Player 2, pick a column (1 through 7)\n").to_stdout
      end

      it 'gets a number from input' do
        allow(game).to receive(:gets).and_return('3')
        expect(game.pick_a_column).to eq(3)
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

  describe '#invalid_selection' do
    it 'prints a message' do
      expect { game.invalid_selection }.to output("Invalid Selection\n").to_stdout
    end
  end

  describe '#win_or_tie?' do
    context 'when its a win' do
      before do
        allow(game).to receive(:check_for_win).and_return(true)
        allow(game).to receive(:print_win_message)
        game.win_or_tie?
      end

      it 'checks for a win' do
        expect(game).to have_received(:check_for_win)
      end

      it 'prints a message' do
        expect(game).to have_received(:print_win_message)
      end

      it 'returns true' do
        expect(game.win_or_tie?).to eq(true)
      end
    end

    context 'when its a tie' do
      before do
        allow(game).to receive(:check_for_win).and_return(false)
        allow(game).to receive(:check_for_tie).and_return(true)
        allow(game).to receive(:print_tie_message)
        game.win_or_tie?
      end

      it 'checks for a tie' do
        expect(game).to have_received(:check_for_tie)
      end

      it 'prints a message' do
        expect(game).to have_received(:print_tie_message)
      end

      it 'returns true' do
        expect(game.win_or_tie?).to eq(true)
      end
    end

    context 'when neither a win nor a tie' do
      before do
        allow(game).to receive(:check_for_win).and_return(false)
        allow(game).to receive(:check_for_tie).and_return(false)
        allow(game).to receive(:print_win_message)
        allow(game).to receive(:print_tie_message)
        game.win_or_tie?
      end

      it 'checks for a win' do
        expect(game).to have_received(:check_for_win)
      end

      it 'checks for a tie' do
        expect(game).to have_received(:check_for_tie)
      end

      it 'does NOT print a win message' do
        expect(game).not_to have_received(:print_win_message)
      end

      it 'does NOT print a tie message' do
        expect(game).not_to have_received(:print_tie_message)
      end

      it 'returns false' do
        expect(game.win_or_tie?).to eq(false)
      end
    end
  end

  describe '#check_for_win' do
    describe 'when horizontal win' do
      before do
        allow(game).to receive(:horizontal_win?).and_return(true)
        allow(game).to receive(:vertical_win?)
        allow(game).to receive(:diagonal_win_up?)
        allow(game).to receive(:diagonal_win_down?)
        game.check_for_win
      end

      it 'checks for horizontal win' do
        expect(game).to have_received(:horizontal_win?)
      end

      it 'does not check for vertical win' do
        expect(game).not_to have_received(:vertical_win?)
      end

      it 'does not check for diagonal win up' do
        expect(game).not_to have_received(:diagonal_win_up?)
      end

      it 'does not check for diagonal win down' do
        expect(game).not_to have_received(:diagonal_win_down?)
      end

      it 'returns true' do
        expect(game.check_for_win).to eq(true)
      end
    end

    describe 'when vertical win' do
      before do
        allow(game).to receive(:horizontal_win?).and_return(false)
        allow(game).to receive(:vertical_win?).and_return(true)
        allow(game).to receive(:diagonal_win_up?)
        allow(game).to receive(:diagonal_win_down?)
        game.check_for_win
      end

      it 'checks for horizontal win' do
        expect(game).to have_received(:horizontal_win?)
      end

      it 'checks for vertical win' do
        expect(game).to have_received(:vertical_win?)
      end

      it 'does not check for diagonal win up' do
        expect(game).not_to have_received(:diagonal_win_up?)
      end

      it 'does not check for diagonal win down' do
        expect(game).not_to have_received(:diagonal_win_down?)
      end

      it 'returns true' do
        expect(game.check_for_win).to eq(true)
      end
    end

    describe 'when diagonal win up' do
      before do
        allow(game).to receive(:horizontal_win?).and_return(false)
        allow(game).to receive(:vertical_win?).and_return(false)
        allow(game).to receive(:diagonal_win_up?).and_return(true)
        allow(game).to receive(:diagonal_win_down?)
        game.check_for_win
      end

      it 'checks for horizontal win' do
        expect(game).to have_received(:horizontal_win?)
      end

      it 'checks for vertical win' do
        expect(game).to have_received(:vertical_win?)
      end

      it 'checks for diagonal win' do
        expect(game).to have_received(:diagonal_win_up?)
      end

      it 'does not check for diagonal win down' do
        expect(game).not_to have_received(:diagonal_win_down?)
      end

      it 'returns true' do
        expect(game.check_for_win).to eq(true)
      end
    end

    describe 'diagonal win down' do
      before do
        allow(game).to receive(:horizontal_win?).and_return(false)
        allow(game).to receive(:vertical_win?).and_return(false)
        allow(game).to receive(:diagonal_win_up?).and_return(false)
        allow(game).to receive(:diagonal_win_down?).and_return(true)
        game.check_for_win
      end

      it 'checks for horizontal win' do
        expect(game).to have_received(:horizontal_win?)
      end

      it 'checks for vertical win' do
        expect(game).to have_received(:vertical_win?)
      end

      it 'checks for diagonal win up' do
        expect(game).to have_received(:diagonal_win_up?)
      end

      it 'checks for diagonal win down' do
        expect(game).to have_received(:diagonal_win_down?)
      end

      it 'returns true' do
        expect(game.check_for_win).to eq(true)
      end
    end

    describe 'when NO win' do
      before do
        allow(game).to receive(:horizontal_win?).and_return(false)
        allow(game).to receive(:vertical_win?).and_return(false)
        allow(game).to receive(:diagonal_win_up?).and_return(false)
        allow(game).to receive(:diagonal_win_down?).and_return(false)
        game.check_for_win
      end

      it 'checks for horizontal win' do
        expect(game).to have_received(:horizontal_win?)
      end

      it 'checks for vertical win' do
        expect(game).to have_received(:vertical_win?)
      end

      it 'checks for diagonal win up' do
        expect(game).to have_received(:diagonal_win_up?)
      end

      it 'checks for diagonal win down' do
        expect(game).to have_received(:diagonal_win_down?)
      end

      it 'returns false' do
        expect(game.check_for_win).to eq(false)
      end
    end
  end

  describe '#print_win_message' do
    context 'when player1 wins' do
      before do
        game.player1 = true
      end

      it 'prints RED wins message' do
        expect { game.print_win_message }.to output("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n!!!!!!!!!!!!!!!!!!! RED WINS !!!!!!!!!!!!!!!!!!!!\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n").to_stdout
      end
    end

    context 'when player2 wins' do
      before do
        game.player1 = false
      end

      it 'prints BLK wins message' do
        expect { game.print_win_message }.to output("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n!!!!!!!!!!!!!!!!!!! BLK WINS !!!!!!!!!!!!!!!!!!!!\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n").to_stdout
      end
    end
  end

  describe '#check_for_tie' do
    context 'when there is a tie' do
      before do
        game.game_board = Array.new(6){Array.new(7, 'NOT')}
      end

      it 'returns true' do
        game.check_for_tie
        expect(game.check_for_tie).to eq(true)
      end
    end

    context 'when there is NOT a tie' do
      before do
        game.game_board = Array.new(6){Array.new(7, '...')}
      end

      it 'returns false' do
        expect(game.check_for_tie).to eq(false)
      end
    end
  end

  describe '#print_tie_message' do
    it 'prints a message' do
      expect { game.print_tie_message }.to output("\n*************************************************\n****************** It's a TIE! ******************\n*************************************************\n\n").to_stdout
    end
  end

  describe '#horizontal_win?' do
    describe 'when the 1st column on the bottom row is NOT empty' do
      describe 'and it matches the next 3 columns' do
        before do
          game.game_board[5][0] = 'BLK'
          game.game_board[5][1] = 'BLK'
          game.game_board[5][2] = 'BLK'
          game.game_board[5][3] = 'BLK'
        end

        it 'we have a winner!' do
          expect(game.horizontal_win?).to eq(true)
        end
      end
    end

    describe 'when the 1st column on the bottom row is NOT empty' do
      describe 'and it does NOT match any of the next 3 columns' do
        before do
          game.game_board[5][0] = 'BLK'
          game.game_board[5][1] = 'BLK'
          game.game_board[5][2] = 'RED'
          game.game_board[5][3] = 'BLK'
        end

        it 'we do not have a winner' do
          expect(game.horizontal_win?).to eq(false)
        end
      end
    end

    describe 'when the 4th column on the bottom row is NOT empty' do
      describe 'and it matches the next 3 columns' do
        before do
          game.game_board[5][3] = 'BLK'
          game.game_board[5][4] = 'BLK'
          game.game_board[5][5] = 'BLK'
          game.game_board[5][6] = 'BLK'
        end

        it 'we have a winner!' do
          expect(game.horizontal_win?).to eq(true)
        end
      end
    end

    describe 'when the 5th column on the bottom row is NOT empty' do
      before do
        game.game_board[5][4] = 'BLK'
      end

      it 'returns false' do
        expect(game.horizontal_win?).to eq(false)
      end
    end

    describe 'when there are no winners on the bottom row' do
      describe 'and there is a winner on the next row up' do
        before do
          game.game_board[5][0] = 'BLK'
          game.game_board[5][1] = 'BLK'
          game.game_board[5][2] = 'BLK'
          game.game_board[5][3] = 'RED'
          game.game_board[5][4] = 'BLK'
          game.game_board[5][5] = 'BLK'
          game.game_board[5][6] = 'BLK'

          game.game_board[4][2] = 'BLK'
          game.game_board[4][3] = 'BLK'
          game.game_board[4][4] = 'BLK'
          game.game_board[4][5] = 'BLK'
        end
        it 'returns true' do
          expect(game.horizontal_win?).to eq(true)
        end
      end
    end

    describe 'when there are no winners on any rows' do
      before do
        game.game_board[5][0] = 'BLK'
        game.game_board[5][1] = 'BLK'
        game.game_board[5][2] = 'BLK'
        game.game_board[5][3] = 'RED'
        game.game_board[5][4] = 'BLK'
        game.game_board[5][5] = 'BLK'
        game.game_board[5][6] = 'BLK'

        game.game_board[4][0] = 'BLK'
        game.game_board[4][1] = 'BLK'
        game.game_board[4][2] = 'BLK'
        game.game_board[4][3] = 'RED'
        game.game_board[4][4] = 'BLK'
        game.game_board[4][5] = 'BLK'
        game.game_board[4][6] = 'BLK'

        game.game_board[3][0] = 'BLK'
        game.game_board[3][1] = 'BLK'
        game.game_board[3][2] = 'BLK'
        game.game_board[3][3] = 'RED'
        game.game_board[3][4] = 'BLK'
        game.game_board[3][5] = 'BLK'
        game.game_board[3][6] = 'BLK'

        game.game_board[2][0] = 'BLK'
        game.game_board[2][1] = 'BLK'
        game.game_board[2][2] = 'BLK'
        game.game_board[2][3] = 'RED'
        game.game_board[2][4] = 'BLK'
        game.game_board[2][5] = 'BLK'
        game.game_board[2][6] = 'BLK'

        game.game_board[1][0] = 'BLK'
        game.game_board[1][1] = 'BLK'
        game.game_board[1][2] = 'BLK'
        game.game_board[1][3] = 'RED'
        game.game_board[1][4] = 'BLK'
        game.game_board[1][5] = 'BLK'
        game.game_board[1][6] = 'BLK'

        game.game_board[0][0] = 'BLK'
        game.game_board[0][1] = 'BLK'
        game.game_board[0][2] = 'BLK'
        game.game_board[0][3] = 'RED'
        game.game_board[0][4] = 'BLK'
        game.game_board[0][5] = 'BLK'
        game.game_board[0][6] = 'BLK'
      end
      it 'returns false' do
        expect(game.horizontal_win?).to eq(false)
      end
    end
  end

  describe '#vertical_win?' do
    describe 'when the 1st column on the bottom row is NOT empty' do
      describe 'and it matches the previous 3 rows' do
        before do
          game.game_board[5][0] = 'BLK'
          game.game_board[4][0] = 'BLK'
          game.game_board[3][0] = 'BLK'
          game.game_board[2][0] = 'BLK'
        end

        it 'we have a winner!' do
          expect(game.vertical_win?).to eq(true)
        end
      end
    end

    describe 'when the 1st column on the bottom row is NOT empty' do
      describe 'and it does NOT match any of the previous 3 rows' do
        before do
          game.game_board[5][0] = 'BLK'
          game.game_board[4][0] = 'BLK'
          game.game_board[3][0] = 'RED'
          game.game_board[2][0] = 'BLK'
        end

        it 'we do not have a winner' do
          expect(game.vertical_win?).to eq(false)
        end
      end
    end

    describe 'when the 4th column on the 4th row is NOT empty' do
      describe 'and it matches the previous 3 rows' do
        before do
          game.game_board[3][3] = 'BLK'
          game.game_board[2][3] = 'BLK'
          game.game_board[1][3] = 'BLK'
          game.game_board[0][3] = 'BLK'
        end

        it 'we have a winner!' do
          expect(game.vertical_win?).to eq(true)
        end
      end
    end

    describe 'when the 1st column on the third row is NOT empty' do
      before do
        game.game_board[2][1] = 'BLK'
      end

      it 'returns false' do
        expect(game.vertical_win?).to eq(false)
      end
    end

    describe 'when there are no winners in the 1st column' do
      describe 'and there is a winner in the next column' do
        before do
          game.game_board[0][0] = 'BLK'
          game.game_board[1][0] = 'BLK'
          game.game_board[2][0] = 'BLK'
          game.game_board[3][0] = 'RED'
          game.game_board[4][0] = 'BLK'
          game.game_board[5][0] = 'BLK'

          game.game_board[4][1] = 'BLK'
          game.game_board[3][1] = 'BLK'
          game.game_board[2][1] = 'BLK'
          game.game_board[1][1] = 'BLK'
        end
        it 'returns true' do
          expect(game.vertical_win?).to eq(true)
        end
      end
    end

    describe 'when there are no winners in any columns' do
      before do
        game.game_board[5][0] = 'BLK'
        game.game_board[4][0] = 'BLK'
        game.game_board[3][0] = 'BLK'
        game.game_board[2][0] = 'RED'
        game.game_board[1][0] = 'BLK'
        game.game_board[0][0] = 'BLK'

        game.game_board[5][1] = 'BLK'
        game.game_board[4][1] = 'BLK'
        game.game_board[3][1] = 'BLK'
        game.game_board[2][1] = 'RED'
        game.game_board[1][1] = 'BLK'
        game.game_board[0][1] = 'BLK'

        game.game_board[5][2] = 'BLK'
        game.game_board[4][2] = 'BLK'
        game.game_board[3][2] = 'BLK'
        game.game_board[2][2] = 'RED'
        game.game_board[1][2] = 'BLK'
        game.game_board[0][2] = 'BLK'

        game.game_board[5][3] = 'BLK'
        game.game_board[4][3] = 'BLK'
        game.game_board[3][3] = 'BLK'
        game.game_board[2][3] = 'RED'
        game.game_board[1][3] = 'BLK'
        game.game_board[0][3] = 'BLK'

        game.game_board[5][4] = 'BLK'
        game.game_board[4][4] = 'BLK'
        game.game_board[3][4] = 'BLK'
        game.game_board[2][4] = 'RED'
        game.game_board[1][4] = 'BLK'
        game.game_board[0][4] = 'BLK'

        game.game_board[5][5] = 'BLK'
        game.game_board[4][5] = 'BLK'
        game.game_board[3][5] = 'BLK'
        game.game_board[2][5] = 'RED'
        game.game_board[1][5] = 'BLK'
        game.game_board[0][5] = 'BLK'

        game.game_board[5][6] = 'BLK'
        game.game_board[4][6] = 'BLK'
        game.game_board[3][6] = 'BLK'
        game.game_board[2][6] = 'RED'
        game.game_board[1][6] = 'BLK'
        game.game_board[0][6] = 'BLK'
      end

      it 'returns false' do
        expect(game.vertical_win?).to eq(false)
      end
    end
  end

  describe '#diagonal_win_up?' do
    describe 'when the 1st column on the bottom row is NOT empty' do
      describe 'and it matches the next 3 items on the diagonal going up' do
        before do
          game.game_board[5][0] = 'BLK'
          game.game_board[4][1] = 'BLK'
          game.game_board[3][2] = 'BLK'
          game.game_board[2][3] = 'BLK'
        end

        it 'we have a winner!' do
          expect(game.diagonal_win_up?).to eq(true)
        end
      end
    end

    describe 'when the 1st column on the bottom row is NOT empty' do
      describe 'and it does NOT match any of the next 3 items on the diagonal going up' do
        before do
          game.game_board[5][0] = 'BLK'
          game.game_board[4][1] = 'BLK'
          game.game_board[3][2] = 'RED'
          game.game_board[2][3] = 'BLK'
        end

        it 'we do not have a winner' do
          expect(game.diagonal_win_up?).to eq(false)
        end
      end
    end

    describe 'when the 2nd column on the bottom row is empty' do
      describe 'and the 3rd column on the 5th row is empty' do
        describe 'and the 4th column on the 4th row is NOT empty' do
          describe 'and it matches the next 3 items on the diagonal going up' do
            before do
              game.game_board[5][1] = '...'
              game.game_board[4][2] = '...'
              game.game_board[3][3] = 'BLK'
              game.game_board[2][4] = 'BLK'
              game.game_board[1][5] = 'BLK'
              game.game_board[0][6] = 'BLK'
            end

            it 'we have a winner!' do
              expect(game.diagonal_win_up?).to eq(true)
            end
          end
        end
      end
    end

    describe 'when the 5th column on the bottom row is NOT empty' do
      before do
        game.game_board[5][4] = 'BLK'
      end

      it 'returns false' do
        expect(game.diagonal_win_up?).to eq(false)
      end
    end
  end

  describe '#diagonal_win_down?' do
    describe 'when the 1st column on the top row is NOT empty' do
      describe 'and it matches the next 3 items on the diagonal going down' do
        before do
          game.game_board[0][0] = 'BLK'
          game.game_board[1][1] = 'BLK'
          game.game_board[2][2] = 'BLK'
          game.game_board[3][3] = 'BLK'
        end

        it 'we have a winner' do
          expect(game.diagonal_win_down?).to eq(true)
        end
      end
    end

    describe 'when the 1st column on the top row is NOT empty' do
      describe 'and it does NOT match any of the next 3 items on the diagonal going down' do
        before do
          game.game_board[0][0] = 'BLK'
          game.game_board[1][1] = 'BLK'
          game.game_board[2][2] = 'RED'
          game.game_board[3][3] = 'BLK'
        end

        it 'we do not have a winner' do
          expect(game.diagonal_win_down?).to eq(false)
        end
      end
    end

    describe 'when the 1st column in the 4th row is NOT empty' do
      before do
        game.game_board[3][0] = 'NOT'
      end
      it 'we do not have a winner' do
        expect(game.diagonal_win_down?).to eq(false)
      end
    end

    describe 'when the 4th column in the 1st row is NOT empty' do
      describe 'and it matches the next 3 items on the diagonal going down' do
        before do
          game.game_board[0][3] = 'BLK'
          game.game_board[1][4] = 'BLK'
          game.game_board[2][5] = 'BLK'
          game.game_board[3][6] = 'BLK'
        end
        it 'we have a winner' do
          expect(game.diagonal_win_down?).to eq(true)
        end
      end
    end

    describe 'when the 2nd column in the 1st row is blank' do
      describe 'and the 3rd column in the 2nd row is blank' do
        describe 'and the 4th column in the 3rd row is NOT blank' do
          describe 'and it matches the next 3 items on the diagonal going down' do
            before do
              game.game_board[0][1] = '...'
              game.game_board[1][2] = '...'
              game.game_board[2][3] = 'RED'
              game.game_board[3][4] = 'RED'
              game.game_board[4][5] = 'RED'
              game.game_board[5][6] = 'RED'
            end
            it 'we have a winner!' do
              expect(game.diagonal_win_down?).to eq(true)
            end
          end
        end
      end
    end

    describe 'when the 1st column in the 2nd row is blank' do
      describe 'and the 2nd column in the 3rd row is not blank' do
        describe 'and it matches the next 3 items going down' do
          before do
            game.game_board[1][0] = '...'
            game.game_board[2][1] = 'RED'
            game.game_board[3][2] = 'RED'
            game.game_board[4][3] = 'RED'
            game.game_board[5][4] = 'RED'
          end
          it 'returns true' do
            expect(game.diagonal_win_down?).to eq(true)
          end
        end
      end
    end
  end
end
