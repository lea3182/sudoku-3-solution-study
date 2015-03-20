require 'pry'
require 'pry-nav'

class Sudoku
  def initialize(board_string)
    @board_string = board_string
    # input = string of numbers representing board
    @cloned_board = board_string
    @formatted_board = self.make_board_array
    @solved = false

  end

  def make_board_array # this turns string into an array of arrays.
    board_to_single_array = @cloned_board.split(//)
    nested_board = Array.new(9) {board_to_single_array.shift(9)}
    nested_board.map { |row| row.map { |cell| cell == "0" ? "123456789" : cell }}
  end

  def board # this returns a single line string representation of the board
    solved == true ? @formatted_board.flatten.join : @cloned_board # needs to be tested to make sure this works!!!!!!!!!!!
  end

  def get_row(row_index)
    #return array of strings (depending on how we format board) with row elements
    @formatted_board[row_index]
  end

  def get_col(column_index)
    # return array of string with column elements
    @formatted_board.transpose[column_index]
  end

  def get_inner_block(row_index, column_index)
    if (0..2).include? (row_index)
      if (0..2).include? (column_index)
        block_0 = []
        block_0 << @formatted_board[0][0..2]
        block_0 << @formatted_board[1][0..2]
        block_0 << @formatted_board[2][0..2]
        return block_0.flatten


      elsif (3..5).include? (column_index)
        block_1 = []
        block_1 << @formatted_board[0][3..5]
        block_1 << @formatted_board[1][3..5]
        block_1 << @formatted_board[2][3..5]
        return block_1.flatten


      else (6..8).include? (column_index)
        block_2 = []
        block_2 << @formatted_board[0][6..8]
        block_2 << @formatted_board[1][6..8]
        block_2 << @formatted_board[2][6..8]
        return block_2.flatten
      end
    end

    if (3..5).include? row_index
      if (0..2).include? (column_index)
        block_3 = []
        block_3 << @formatted_board[3][0..2]
        block_3 << @formatted_board[4][0..2]
        block_3 << @formatted_board[5][0..2]
        return block_3.flatten

      elsif (3..5).include? (column_index)
        block_4 = []
        block_4 << @formatted_board[3][3..5]
        block_4 << @formatted_board[4][3..5]
        block_4 << @formatted_board[5][3..5]
        return block_4.flatten!

      else (6..8).include? (column_index)
        block_5 = []
        block_5 << @formatted_board[3][6..8]
        block_5 << @formatted_board[4][6..8]
        block_5 << @formatted_board[5][6..8]
        return block_5.flatten
      end
    end

    if (6..8).include? (row_index)
      if (0..2).include? (column_index)
        block_6 = []
        block_6 << @formatted_board[6][0..2]
        block_6 << @formatted_board[7][0..2]
        block_6 << @formatted_board[8][0..2]
        return block_6.flatten

      elsif (3..5).include? (column_index)
        block_7 = []
        block_7 << @formatted_board[6][3..5]
        block_7 << @formatted_board[7][3..5]
        block_7 << @formatted_board[8][3..5]
        return block_7.flatten

      else (6..8).include? (column_index)
        block_8 = []
        block_8 << @formatted_board[6][6..8]
        block_8 << @formatted_board[7][6..8]
        block_8 << @formatted_board[8][6..8]
        return block_8.flatten
      end
    end
  end

  def solved?
    if @formatted_board.join.length != 81
      return false
    else
      # check rows and columns
      0.upto(8) do |num|
        if get_row(num).sort != ('1'..'9').to_a
          return false
       elsif get_col(num).sort != ('1'..'9').to_a
          return false
        end
      end
      # check inner blocks
      0.upto(8) do |row|
        0.upto(8) do |col|
          if get_inner_block(row,col).sort != ('1'..'9').to_a
            return false
          end
        end
      end
    end
    @solved = true
  end

  def compare_array(array)
    array.clone.delete_if {|element| element.length > 1}
  end

  def solve!
    # this is the base case for using our recursive technique
    if @solved
      return @formatted_board
    end

# until every element in every array in the @formatted_board has a length of one do
  # find an array element inside array where string length > 1
    previous_length = 0
    until @formatted_board.join.length == 81 #100.times do
      0.upto(8) do |row|
        0.upto(8) do |col|
          cell = @formatted_board[row][col]
          cell.each_char do |character|
            if cell.length > 1
              if compare_array(get_row(row)).include? character
                cell.delete!(character)
              elsif compare_array(get_col(col)).include? character
                cell.delete!(character)
              elsif compare_array(get_inner_block(row,col)).include? character
                cell.delete!(character)
              end
            end
          end
        end
      end
      if @formatted_board.join.length == previous_length
        # @possible_answers = []
        # test = @formatted_board.flatten
        # test.each {|element| element.length > 1 ? test[element] : nil }
        #     @possible_answers << element
          # end
        break
      end
      previous_length = @formatted_board.join.length
    end

    unless @solved
      solve_recursively(@formatted_board)
    end





    @solved = true ###################changed this by adding if
    @formatted_board.join
    # else
      #create loop that deletes randomly one character from each string with > 1 character, until one is presented that satisfies the solved variable
  end
  def solve_recursively(board)
    # test = @formatted_board.join
    if @solved
      # @formatted_board = guess_board
      return true
    end
    # if !@solved
    #   return false
    # end
      # guess_board = Sudoku.new(@formatted_board.map { |row| row.map { |cell| cell.length > 1 ? "0" : cell }})
    0.upto(8) do |row|
      0.upto(8) do |col|
        cell = board[row][col]
        if cell.length > 1
          cell.each_char do |character|
            board[row][col] = character
            guess_board = Sudoku.new(@formatted_board.join)
            guess_board.solve!
            if guess_board.solve! == !@solved #solve_recursively is false
              board[row][col] = cell.delete(character)
              solve_recursively(guess_board)# character that we tested
            else
              guess_board.solve! == @solved #solve_recursively(board) is true
              @formatted_board = guess_board
            end
          end
        end
      end
    end
end
  # Returns a string representing the current state of the board

  def to_s
    if @formatted_board.join.length > 81
      array_to_format = @formatted_board.map { |row| row.map { |cell| cell.length > 1 ? "0" : cell }}
    else
      array_to_format = @formatted_board.flatten
    end
    solution_string = array_to_format.join.gsub(/(\w{3})\D{0,1}(\w{3})\D{0,1}(\w{3})/, ' \1 | \2 | \3 '+"\n")
    solution_string = "----------------\n" + solution_string + "----------------"
    solution_string.insert(70, "\n----------------")
    solution_string.insert(140, "\n----------------")
  end

    # input = none
    # output = string with new line every 9 characters and space between others
  # end
end

test_board0 = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
test_board1 = Sudoku.new('005030081902850060600004050007402830349760005008300490150087002090000600026049503')
test_board2 = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
test_board3 = Sudoku.new('005030081902850060600004050007402830349760005008300490150087002090000600026049503')
test_board4 = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
test_board5 = Sudoku.new('005030081902850060600004050007402830349760005008300490150087002090000600026049503')
test_board6 = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
test_board7 = Sudoku.new('005030081902850060600004050007402830349760005008300490150087002090000600026049503')
# test_board_fucked = Sudoku.new('000689100800000029150000008403000050200005000090240801084700910500000060060410000')

puts "test board should be unsolved: #{test_board0.solved?}}"
test_board0.solve!
puts "test board should be solved: #{test_board0.solved?}}"
puts test_board0.to_s
test_board1.solve!
puts test_board1.to_s
test_board2.solve!
puts test_board2.to_s
test_board3.solve!
puts test_board3.to_s
test_board4.solve!
puts test_board4.to_s
test_board5.solve!
puts test_board5.to_s
test_board6.solve!
puts test_board6.to_s
test_board7.solve!
puts test_board7.to_s
# test_board_fucked.solve!
# puts "test board should be unsolved: #{test_board_fucked.solved?}}"
# puts test_board_fucked.to_s