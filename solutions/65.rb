require 'pry'
require 'debugger'

class Sudoku
  def initialize(board_string)
    board_split = board_string.split("")
    @board = Array.new(9) {board_split.shift(9)}
    @sudoku_numbers = [1,2,3,4,5,6,7,8,9]
  end

  def solve_this
    # debugger
    @board.each_with_index do |board_row, row_index|
        if board_row.include?("-")
            board_row.each_with_index do |board_col, col_index| #then iterate through each cell
                if board_col == "-"
                    if check_row(row_index).is_a?Integer
                      @board[row_index][column_index] = check_row(row_index)
                    # elsif check_square(row_index, col_index).is_a?Integer
                    #     @board[row_index][column_index] = check_square(row_index, col_index)
                    # elsif check_column(row_index, col_index).is_a?Integer
                    #     @board[row_index][column_index] = check_col(row_index, col_index)
                    else
                        return false
                    end
                # else
                #     return true
                end
                @board
            end
        else
            puts "You exited the loop" # No empty spaces, return true
        end
    end

    # ITERATE through row arrays and check to see if there is an empty space // "-"
    # RETURN TRUE if there are no empty spaces
    # IF there are empty spaces
    ## LOOP through all spaces until there are no more empty spaces
    ### CHECKING each space, is it empty?
    #### IF NOT EMPTY, check next space
    #### IF IS EMPTY
    ##### COMPARE with row, column, and square to see if there is ONE possibility (check against array rows/columns/squares to see what it's missing)
    ##### IF NOT ONE possibility, check next space
    ##### IF ONE POSSIBILITY, reassign value





  end

    def check_square(row_index, col_index)

        # CHECK which square you are in based on the current cell
        # APPEND all the numbers into an array

        # IF [row]/3 == 0 && [column]/3 == 0 THEN starting coordinates will be [0][0]
        # row + 1, row + 2
        # col + 1, col + 2
        ### CHECKING SQUARES
        #   ABOVE ROW
        #   a[row-1][col-1]
        #   a[row-1][col]
        #   a[row-1][col+1]
        #   SAME ROW
        #   a[row][col-1]
        #   a[row][col] WHERE WE ARE
        #   a[row][col+1]
        #   BELOW ROW
        #   a[row+1][col-1]
        #   a[row+1][col]
        #   a[row+1][col+1]

        board = @board.dup
        square_length = []
        missing_number = false

        if 0 <= row_index && 2 >= row_index  && 0 <= col_index && 2>= col_index #THEN SQUARE 1
        # SQUARE 1
            row = 0
            col = 0

            3.times do
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 0
            3.times do
                row = 1
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 0
            3.times do
                row = 2
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            if square_length.length == 8
              missing_number =  (@sudoku_numbers - square_length).to_i
            end

            missing_number
        # if eight_length.length == 8, then this is when we would find out which number is missing and assign the number to that location
        # square[0][0] // square[0][1] // square[0][2]
        # square[1][0] // square[1][1] // square[1][2]
        # square[2][0] // square[2][1] // square[2][2]

        elsif 0 <= row_index && 2 >= row_index && 3 <= col_index &&  5 >= col_index # THEN SQUARE 2

            row = 0
            col = 3

            3.times do
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 3
            3.times do
                row = 1
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 3
            3.times do
                row = 2
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

             if square_length.length == 8
                   missing_number =  (@sudoku_numbers - square_length).to_i
             end
             missing_number
        # square[0][3] // square[0][4] // square[0][5]
        # square[1][3] // *square[1][4] // square[1][5]
        # square[2][3] // square[2][4] // square[2][5]

        elsif 0 <= row_index && row_index >= 2 && 6 <= col_index && 8 >= col_index # THEN SQUARE 3

            row = 0
            col = 6

            3.times do
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 6
            3.times do
                row = 1
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 6
            3.times do
                row = 2
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

             if square_length.length == 8
                   missing_number =  (@sudoku_numbers - square_length).to_i
             end
             missing_number
        # square[0][6] // square[0][7] // square[0][8]
        # square[1][6] // square[1][7] // square[1][8]
        # square[2][6] // square[2][7] // square[2][8]

        elsif 3 <= row_index && row_index <= 5 && col_index >= 0 && col_index <= 2 # THEN SQUARE 4
            row = 3
            col = 0

            3.times do
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 0
            3.times do
                row = 4
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 0
            3.times do
                row = 5
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

             if square_length.length == 8
                   missing_number =  (@sudoku_numbers - square_length).to_i
             end
             missing_number
        # square[3][0] // square[3][1] // square[3][2]
        # square[4][0] // square[4][1] // square[4][2]
        # square[5][0] // square[5][1] // square[5][2]

        elsif 3 <= row_index && row_index <= 5 && 3 <= col_index && col_index <= 5 # THEN SQUARE 5
            row = 3
            col = 3

            3.times do

                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 3
            3.times do
                row = 4
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 3
            3.times do
                row = 5
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end
             if square_length.length == 8
                   missing_number =  (@sudoku_numbers - square_length).to_i
              end
              missing_number
        # square[3][3] // square[3][4] // square[3][5]
        # square[4][3] // square[4][4] // square[4][5]
        # square[5][3] // square[5][4] // square[5][5]

        elsif 3 <= row_index && row_index <= 5 && 6 <= col_index && col_index <= 8 # THEN SQUARE 6

            row = 3
            col = 6

            3.times do
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 6
            3.times do
                row = 4
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 6
            3.times do
                row = 5
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end
            if square_length.length == 8
                   missing_number =  (@sudoku_numbers - square_length).to_i
            end
            missing_number
        # square[3][6] // square[3][7] // square[3][8]
        # square[4][6] // square[4][7] // square[4][8]
        # square[5][6] // square[5][7] // square[5][8]

        elsif 6 <= row_index && row_index <= 8 && 0 <= col_index && col_index <= 2 # THEN SQUARE 7

            row = 6
            col = 0

            3.times do
            square[row][col].delete("-")
            square_length << square[row][col]
            col += 1
            end

            col = 0
            3.times do
            row = 7
            square[row][col].delete("-")
            square_length << square[row][col]
            col += 1
            end

            col = 0
            3.times do
            row = 8
            square[row][col].delete("-")
            square_length << square[row][col]
            col += 1
            end

            if square_length.length == 8
                missing_number =  (@sudoku_numbers - square_length).to_i
            end
            missing_number
        # square[6][0] // square[6][1] // square[6][2]
        # square[7][0] // square[7][1] // square[7][2]
        # square[8][0] // square[8][1] // square[8][2]

        elsif 6 <= row_index && row_index <= 8 && 3 <= col_index && col_index <= 5 # SQUARE 8
            row = 6
            col = 3

            3.times do
            board[row][col].delete("-")
            square_length << board[row][col]
            col += 1
            end

            col = 3
            3.times do
            row = 7
            board[row][col].delete("-")
            square_length << board[row][col]
            col += 1
            end

            col = 3
            3.times do
            row = 8
            board[row][col].delete("-")
            square_length << board[row][col]
            col += 1
            end

             if square_length.length == 8
                   missing_number =  (@sudoku_numbers - square_length).to_i
             end
             missing_number
        # square[6][3] // square[6][4] // square[6][5]
        # square[7][3] // square[7][4] // square[7][5]
        # square[8][3] // square[8][4] // square[8][5]

        elsif 6 <= row_index && row_index <= 8 && 6 <= col_index && col_index <= 8 #THEN SQUARE 9

            row = 6
            col = 6

            3.times do
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 6
            3.times do
                row = 7
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end

            col = 6
            3.times do
                row = 8
                board[row][col].delete("-")
                square_length << board[row][col]
                col += 1
            end
             if square_length.length == 8
                   missing_number =  (@sudoku_numbers - square_length).to_i
              end
              missing_number
        # square[6][6] // square[6][7] // square[6][8]
        # square[7][6] // square[7][7] // square[7][8]
        # square[8][6] // square[8][7] // square[8][8]
        end
        missing_number
    end

    def check_row(row)

        missing_number = false
        new_board = @board.dup
        new_board[row].delete("-")
        new_board[row].map! { |x| x.to_i}
        if new_board[row].length == 8
            missing_number = (@sudoku_numbers - new_board[row])
        end
        missing_number.map! {|x| x.to_i}
    end

    def check_column(row, col)

        missing_number = false
        new_board = @board.dup
        transpose_board = new_board.transpose
        check_column = transpose_board[col]
        col_length = check_column.length
        if col_length == 8
           missing_number =  (@sudoku_numbers - check_column)
         end
        missing_number.to_i
    end

  def solve?
      return true if solve_this
  end

  def board
    # SHOW the updated board with the new values
  end

  # Returns a nicely formatted string representing the current state of the board
  def to_s
    display_board = ""
    @board.each do |cell|
      cell.each do |number|
        display_board << "#{number}".ljust(3)
      end
      display_board << "\n"
    end
    print display_board
  end

end

board = '4-5269781682571493197834562826195347374682915951743628519326874248957136763418259'
# print board
test = Sudoku.new(board)
test.to_s
test.solve_this
puts " "
test.to_s