require_relative '../app/models/game'
require_relative '../app/models/win_or_tie'

describe 'WinOrTie' do
  let(:game) { Game.new }

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
      let(:win_message) { "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n!!!!!!!!!!!!!!!!!!! RED WINS !!!!!!!!!!!!!!!!!!!!\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n" }

      before do
        game.player1 = true
      end

      it 'prints RED wins message' do
        expect { game.print_win_message }.to output(win_message).to_stdout
      end
    end

    context 'when player2 wins' do
      let(:win_message) { "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n!!!!!!!!!!!!!!!!!!! BLK WINS !!!!!!!!!!!!!!!!!!!!\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n" }

      before do
        game.player1 = false
      end

      it 'prints BLK wins message' do
        expect { game.print_win_message }.to output(win_message).to_stdout
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
    let(:tie_message) { "\n*************************************************\n****************** It's a TIE! ******************\n*************************************************\n\n" }
    it 'prints a message' do
      expect { game.print_tie_message }.to output(tie_message).to_stdout
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
