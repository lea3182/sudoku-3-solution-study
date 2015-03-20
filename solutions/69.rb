
#------- nouns ------#
### board
### size of the board
### blocks
### spaces
### numbers (1-9)
### column
### row
### intersection

#------ steps -----#
### look for the block which is populated the most
### Create the hash of slots that are empty (empty_slots_in_block)

# Scan the list
### Count how many slots are in empty_slots_in_the_block
### If 1
###### fill that number into the slot
### If more than 1
###### pick an empty space from that block
###### locate the row and the column whose intersection is the space
###### check the row
######### scan the numbers
######### check out the numbers that are missing (row_missing)
###### check the column
######### scan the numbers
######### check out the numbers that are missing (col_missing)
###### back to the block
######### what numbers are missing?(block_missing)
###### Record the missing numbers that overlap amongst all row_missing, col_missing, block_missing
###### How many are there?

### If 1....
###### Fill in that number to the space
### If more than 1
###### Move on to the next slot in the empty_slots_in_the_list and repeat the same process until the
###### array is empty.


#------ verbs ------#
### Sort blocks
### get_row
### get_column
### find_numbers_missing

#------- variables ------#
### board
### ordered_blocks
### numbers_missing


class Sudoku

  attr_accessor :numbers_missing
  attr_reader :sudoku_board, :solution

  def initialize(board_string)
    @sudoku_board = []
    # @blocks = [[0, 1, 2, 9, 10, 11, 18, 19, 20],
    #           [3, 4, 5, 12, 13, 14, 21, 22, 23],
    #           [6, 7, 8, 15, 16, 17, 24, 25, 26],
    #           [27, 28, 29, 36, 37, 38, 45, 46, 47],
    #           [30, 31, 32, 39, 40, 41, 48, 49, 50],
    #           [33, 34, 35, 42, 43, 44, 51, 52, 53],
    #           [54, 55, 56, 63, 64, 65, 72, 73, 74],
    #           [57, 58, 59, 66, 67, 68, 75, 76, 77],
    #           [60, 61, 62, 69, 70, 71, 78, 79, 80]]
    board_string.to_s.split('').each_with_index do | number, index |
      # search through each row of blocks
      # serch for index
      # if found,
      #   create a slot object(number, index, index of @blocks)
      #   break out of the loop
      # @blocks.each_with_index do | block_array, block_index |
        # if block_array.include?(index)
          @sudoku_board << Slot.new(number.to_i, index)
          # break
        # end
      # end
    end
  end

  def solved?
    @sudoku_board.find {|slot| slot.number.zero? }.nil?
  end

  def get_block(index)
    start = ((index/27)*27) + ((index%9)/3)*3
    block = []
    (0..2).to_a.each do |i|
      (0..2).to_a.each do |j|
        block << sudoku_board[start + i + j * 9]
      end
    end
    (1..9).to_a - block.map(&:number).select {|n| n != 0}
  end

    # @board.each do |row|
    #   board_string << row.map(&:letter).join(" ") + "\n"
    # end
    # board_string

  def solve!()

    until solved?
      # Search through @sudoku_board until 0 is found
      zeros_to_fill = search_for_zeros
      # Create base case
      # If zeros_to_fill is empty, return solution
      # If no empty keep on going
      # if zeros_to_fill.empty?
      #   return self.board
      # # elsif i >= 50
      # #   return
      # else
      # Go through each slot of zeros_to_fill
        zeros_to_fill.each do |zero|
          # Search through the row and record the slot objects whose number is 0 in an array(row_missing)
          row = @sudoku_board.select { |slot| slot.row == zero.row }
          missing_nums_in_row = self.determine_missing_nums(row).map(&:number)
          row_guesses = (1..9).to_a - missing_nums_in_row
          #row.each { |slot| puts "#{slot.row}"}
          # Search through the column and record the slot objects whose number is 0 in an array(column_missing)
          column = @sudoku_board.select { |slot| slot.column == zero.column }
          missing_nums_in_column = self.determine_missing_nums(column).map(&:number)
          column_guesses = (1..9).to_a - missing_nums_in_column
          # Search through the block and record the slot objects whose number is 0 in an array(block_missing)

          block_guesses = get_block(zero.index)
          # Determine the common slots of all row_missing, column_missing, block_missing (missing_nums_total)

          missing_nums_total = column_guesses & row_guesses & block_guesses
          # If missing_nums_total lenght is one, change that object's number.
          case missing_nums_total.length
          when 0
            raise Impossible
          when 1
            zero.number = missing_nums_total[0]
          # Repeat thae process until the board has no zero
          # else
          #   solve!(i+=1)
          end
        end
      # end
    end
  end

  class Impossible < StandardError
  end

  def search_for_zeros
    @sudoku_board.select { |slot| slot.number == 0 }
  end

  def determine_missing_nums(array_to_search)
    array_to_search.select { |slot| !(1..9).map(&:to_s).include?(slot.number) && slot.number != 0 }
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    @sudoku_board.map { |slot| slot.number }.join.to_i
  end

  def to_s
    @sudoku_board.each do |slot|
      puts "number: #{slot.number}"
      puts "row:    #{slot.row}"
      puts "column: #{slot.column}"
      puts "----------------------"
    end
  end

end


# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('set-01_sample.unsolved.txt').first.chomp

# game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
# game.solve!

class Slot

  attr_accessor :number
  attr_reader :row, :column, :index

  def initialize(number, index)
    @number = number
    @row, @column = index.divmod(9)
    @index = index
  end


end



sudoku_board = Sudoku.new(105802000090076405200400819019007306762083090000061050007600030430020501600308900)
# sudoku_board.board
#p sudoku_board.board
#p sudoku_board.sudoku_board.map do |slot|

# 105802000
# 090076405
# 200400819
# 019007306
# 762083090
# 000061050
# 007600030
# 430020501
# 600308900

# i = 1
# sudoku_board.search_for_zeros.each do |slot|
#   puts "#{i}. #{slot.number}"
#   i += 1
# end

# puts "----------------------------------------"

# to_print = sudoku_board.sudoku_board.select { |slot| !(1..9).map(&:to_s).include?(slot.number) && slot.number != 0 }
# j = 1
# to_print.each do |slot|
#   puts "#{j}. #{slot.number}"
#   j += 1
# end
sudoku_board.sudoku_board.map(&:number).each_slice(9) do |row|
  print row.join(" ") + "\n"
end

sudoku_board.solve!
puts
sudoku_board.sudoku_board.map(&:number).each_slice(9) do |row|
  print row.join(" ") + "\n"
end