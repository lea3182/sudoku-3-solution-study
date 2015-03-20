#setter: sets board
#player: solved board
# finds first "0" (x = 0)
# first checks whats on that x's row. Takes those numbers and stores it in check?
# next checks for any leftover numbers in column
# than checks for leftover numbers in box matrix
# if leftover == 1, replace "0" with the leftover number
# else move on to the next check

#tackle it

# 1. skeleton
# 2. check row, get it working
# 3. check column
# 4. check box

# How do we create a box model?
# How do we compare each "machine"?



class Sudoku
  def initialize(board_string)
    first_board = board_string.split(//)
    @game_board = first_board.each_slice(9).to_a
  end

  def solve!
    #Find a 0, reiteate through that row, get all values except 0
    # while @game_board.flatten.include?("0")
      @game_board.each_with_index do |row, row_index|
        row.each_with_index do |num, num_index|
        @check_array = ["1","2","3","4","5","6","7","8","9"]
           # row.each_index { |index| p index }
          if num == "0" #begin checks
            row_check(row_index, num_index)
            column_check(row_index, num_index)
            # box_check(num)

            #After the 3 checks are complete, if remainder in the check_array == 1
            #replace number with check_array value, otherwise move to next 0
            # num.replace(@check_array[0]) # think of 0 as "x" or "i" or..
          else
            num
          end
        end
      end
    # end
    # return @game_board
  end

  #Row check
  def row_check(row, column) #[0][1]
    original_col = column
    # p "In row.check loop row: #{row}, col: #{column}"

    #Check row moving towards the right
    while column <= 8
      test_num = @game_board[row][column]

      if test_num != "0"
        # p test_num.to_s
        @check_array.delete(test_num)
        column += 1
      else
        column += 1
      end
    # return @check_array
    end

    # p "the column you are on after the first while loop is #{column}"
    # p "the original column you are on after the first while loop is #{original_col}"
    #Check row moving towards the left
    while original_col >= 0
      test_num = @game_board[row][original_col]

      if test_num != "0"
        # p test_num.to_s
        @check_array.delete(test_num)
        original_col -= 1
      else
        original_col -= 1
      end
    end
    return @check_array
  end

  #Column check
  def column_check(row, column)
    p "In column.check loop row: #{row}, col: #{column}"
    p @check_array
  end

  #Box check
  def box_check(zero)
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    # split_letters = @board_string.partition { |group| }
    # p split_letters
    # @empty_board.each { |row| puts row }
    @game_board.each_with_index {|row| p row}
  # end
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

game.board
