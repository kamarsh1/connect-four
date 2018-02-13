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
    context 'when the game is NOT over' do
      context 'loop until the game IS over' do
        before do
          allow(game).to receive(:display_board)
          allow(game).to receive(:make_a_move)
          allow(game).to receive(:win_or_tie?).and_return(false, false, false, false, true)
          game.play
        end

        #### Still need to work this out ###
        #### problem is I need to set player1 to false b4 the game plays
        ####
        # it 'toggles player1' do
        #   player1_toggle = !game.player1
        #   expect(game.player1).to eq(player1_toggle)
        # end

        it 'displays the board' do
          expect(game).to have_received(:display_board).exactly(5).times
        end

        it 'makes a move' do
          expect(game).to have_received(:make_a_move).exactly(5).times
        end

        it 'checks for game over' do
          expect(game).to have_received(:win_or_tie?).exactly(5).times
        end
      end
    end
  end

  # describe '#make_a_move' do
  #   context 'when it is NOT a valid move' do
  #     context 'it loops until there IS a valid move' do
  #       before do
  #         allow(game.make_a_move).to receive(:pick_a_column).and_return(0, 9, 4)
  #         allow(game.make_a_move).to receive(:valid_move?).and_return(false, false, true)
  #         allow(game.make_a_move).to receive(:place_chip_in_column)
  #         allow(game.make_a_move).to receive(:invalid_selection)
  #         allow(game.make_a_move).to receive(:display_board)
  #       end
  #
  #       it 'calls pick a column until a valid move' do
  #         expect(game.make_a_move).to have_received(:pick_a_column).exactly(3).times
  #       end
  #
  #       it 'checks if each move is valid' do
  #         expect(game.make_a_move).to have_received(:valid_move?).exactly(3).times
  #       end
  #
  #       it 'calls invalid selection for each invalid move' do
  #         expect(game.make_a_move).to have_received(:invalid_selection).twice
  #       end
  #
  #       it 'places chip in column' do
  #         expect(game.make_a_move).to have_received(:place_chip_in_column).once
  #       end
  #       #
  #       # it 'displays the board' do
  #       #   expect(game.make_a_move).to have_received(:display_board).exactly(3).times
  #       # end
  #     end
  #   end
  # end
    # context 'until the game is over' do
    #   before do
    #     allow(game).to receive(:display_board)
    #     allow(game).to receive(:make_a_move)
    #     allow(game).to receive(:win_or_tie?).and_return(true)
    #   end
    #
    #   it 'toggles player1' do
    #     player1_toggle = !game.player1
    #     game.play
    #     expect(game.player1).to eq(player1_toggle)
    #   end
    #
    #   it 'displays the board' do
    #     game.play
    #     expect(game).to have_received(:display_board)
    #   end
    #
    #   it 'makes a move' do
    #     game.play
    #     expect(game).to have_received(:make_a_move)
    #   end
    #
    #   it 'checks for game over' do
    #     game.play
    #     expect(game).to have_received(:win_or_tie?)
    #   end
    # end
    # context 'when it is a VALID move' do
    #   before do
    #     allow(game).to receive(:display_board)
    #     allow(game).to receive(:pick_a_column).and_return(3)
    #     allow(game).to receive(:valid_move?).and_return(true)
    #     allow(game).to receive(:place_chip_in_column)
    #     allow(game).to receive(:invalid_selection)
    #     allow(game).to receive(:win_or_tie?)
    #     game.play
    #   end
    #
    #     # it 'toggles player1' do
    #     #   player1_toggle = !game.player1
    #     #   game.play
    #     #   expect(game.player1).to eq(player1_toggle)
    #     # end
    #
    #   it 'displays the board' do
    #     expect(game).to have_received(:display_board).twice
    #   end
    #
    #   it 'picks a column' do
    #     expect(game).to have_received(:pick_a_column).once
    #   end
    #
    #   it 'places chip in column' do
    #     expect(game).to have_received(:place_chip_in_column).once
    #   end
    #
    #   it 'does NOT call invalid_selection' do
    #     expect(game).not_to have_received(:invalid_selection)
    #   end
    #
    #   it 'checks if win or tie' do
    #     expect(game).to have_received(:win_or_tie?)
    #   end
    #
    #   context 'when it IS a win or tie' do
    #     before do
    #       allow(game).to receive(:win_or_tie?).and_return(true)
    #     end
    #
    #     it 'ends the game' do   ### this is kind of hokey - figure out what to expect
    #       expect(game).to have_received(:win_or_tie?)
    #     end
    #   end
    #
    #   # context 'when it is NOT a win or a tie' do
    #   #   context 'it keeps playing until there IS a win or a tie' do
    #   #     before do
    #   #       allow(game).to receive(:display_board)
    #   #       allow(game).to receive(:pick_a_column)
    #   #       allow(game).to receive(:valid_move?)
    #   #       allow(game).to receive(:place_chip_in_column)
    #   #       allow(game).to receive(:win_or_tie?).and_return(false)
    #   #
    #   #       game.play
    #   #     end
    #   #
    #   #     it 'does it all over again' do
    #   #
    #   #     end
    #   #   end
    #   # end
    # end
    #
    # context 'when it is NOT a valid move' do
    #   context 'it loops until there IS a valid move' do
    #     before do
    #       allow(game).to receive(:display_board)
    #       allow(game).to receive(:pick_a_column).and_return(0, 9, 4)
    #       allow(game).to receive(:valid_move?).and_return(false, false, true)
    #       allow(game).to receive(:place_chip_in_column)
    #       allow(game).to receive(:invalid_selection)
    #
    #       game.play
    #     end
    #
    #     it 'calls pick a column until a valid move' do
    #       expect(game).to have_received(:pick_a_column).exactly(3).times
    #     end
    #
    #     it 'checks if each move is valid' do
    #       expect(game).to have_received(:valid_move?).exactly(3).times
    #     end
    #
    #     it 'calls invalid selection for each invalid move' do
    #       expect(game).to have_received(:invalid_selection).twice
    #     end
    #
    #     it 'places chip in column' do
    #       expect(game).to have_received(:place_chip_in_column).once
    #     end
    #   end
    # end

  describe '#display_board' do
    let(:board) {"\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n[\"...\", \"...\", \"...\", \"...\", \"...\", \"...\", \"...\"]\n\n"}

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

  # describe '#win_or_tie?' do
  #   context 'when its a win' do
  #     it 'returns true' do
  #       expect(game.win_or_tie?).to eq(true)
  #     end
  #   end
  # end
end
