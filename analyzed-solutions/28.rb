
require 'debugger'
require 'Matrix'

class Sudoku
  attr_accessor :board, :block_array, :test_num, :check_num, :other_nums
  def initialize(board_string)
    board_converter = board_string.split("")
    @board = []
    board_converter.each_slice(9) {|row| board << row}
    @@numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
    block_array_converter = board
    @block_array = []
    reg_to_block_converter
  end

  def reg_to_block_converter
    @@blocks_by_first_index = [[0,0],[0,3],[0,6],[3,0],[3,3],[3,6],[6,0],[6,3],[6,6]]
    board.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        index_of_first_in_block = [row_index, column_index]
        if @@blocks_by_first_index.include?(index_of_first_in_block)
          matrix_converter = Matrix[*board]
          matrix_converter = matrix_converter.minor((index_of_first_in_block[0]..(index_of_first_in_block[0]+2)), (index_of_first_in_block[1]..index_of_first_in_block[1]+2))
          block_array << matrix_converter.to_a.flatten
        end
      end
    end
  end

  def solve! #controller
    while board.flatten.include?("0")
      board.each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          if board[row_index][column_index] == "0"
            @@numbers.each do |check_num|
              if possible?(row_index, column_index, check_num)
                other_nums = @@numbers.reject{|num| num == check_num}
                if only?(row_index, column_index, other_nums)
                  populate(row_index, column_index, check_num)
                end
              end
            end
          end
        end
      end
    end
    return print_board
  end

  def possible? (row_index, column_index, test_num) # checks current number only on row, col, square
    p test_num
    p row_index
    p column_index
    p block_array[block_check(row_index,column_index)]
    if board[row_index].include?(test_num)
      return false
    elsif board.transpose[column_index].include?(test_num)
      return false
    elsif block_array[block_check(row_index,column_index)].include?(test_num)
      return false
    else
      return true
    end
  end

  def block_check (row_index, column_index)
    if (0..2).include?(row_index) && (0..2).include?(column_index)
      return 0
    elsif (0..2).include?(row_index) && (3..5).include?(column_index)
      return 1
    elsif (0..2).include?(row_index) && (6..8).include?(column_index)
      return 2
    elsif (3..5).include?(row_index) && (0..2).include?(column_index)
      return 3
    elsif (3..5).include?(row_index) && (3..5).include?(column_index)
      return 4
    elsif (3..5).include?(row_index) && (6..8).include?(column_index)
      return 5
    elsif (6..8).include?(row_index) && (0..2).include?(column_index)
      return 6
    elsif (6..8).include?(row_index) && (3..5).include?(column_index)
      return 7
    elsif (6..8).include?(row_index) && (6..8).include?(column_index)
      return 8
    end
  end

  def only? (row_index, column_index, other_nums)
    other_nums.each do |other|
      if possible?(row_index, column_index, other)
        return false
      end
    end
    return true
  end

  def populate(row_index, column_index, test_num) #model
    board[row_index][column_index].gsub!(/0/, test_num)
  end

  def print_board #view
    row_counter = 0
    column_counter = 0
    board.each do |row|
      row.each do |num|
        if column_counter == 3 || column_counter == 6
          print "|"
        end
        print num
        column_counter += 1
      end
      column_counter = 0
      if row_counter == 2 || row_counter == 5
        print "\n" + "--- --- ---"
      end
      print "\n"
      row_counter += 1
    end
  end
end

board_string = "619030040270061008000047621486302079000014580031009060005720806320106057160400030"

game = Sudoku.new(board_string)

game.solve!