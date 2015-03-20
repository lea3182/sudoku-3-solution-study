###################################################################
#######################     Release 0     #########################
###################################################################
################### Eric Johnson and Drew West ####################
###################################################################

# Setter - Person who created the puzzle
# Player - Person who solves the puzzle
# Grid - the entire 81-cell, 9x9 board
# Square - A 3x3 subset of the grid, sectioned by bold lines, containing 9 cells
# Cell - A single unit place, the smallest element of the board

# Don't use nested array data structure
# Don't isolate the starting cell for Release 0, use an iterative loop

# Pseudocode
# Input: An 81-character string representing the values in each cell of the board
# Output: A completed 81-character string in which all values have been solved (no 0s)
# and a printout representing a completed board board

# puts "game.board" should return:
# ---------------------
# 4 8 3 | 9 2 1 | 6 5 7
# 9 6 7 | 3 4 5 | 8 2 1
# 2 5 1 | 8 7 6 | 4 9 3
# ---------------------
# 5 4 8 | 1 3 2 | 9 7 6
# 7 2 9 | 5 6 4 | 1 3 8
# 1 3 6 | 7 9 8 | 2 4 5
# ---------------------
# 3 7 2 | 6 8 9 | 5 1 4
# 8 1 4 | 2 5 3 | 7 6 9
# 6 9 5 | 4 1 7 | 3 8 2
# ---------------------

# STEPS:
# 1. Create a solution set of values of possible answers for any cell [1, 2, 3, 4, 5, 6, 7, 8, 9]
# 2. Create a program that will successively check each cell to determine if it is empty
#    (will be represented by a 0 in the 81-char string)
# 3. When the program finds an empty cell, compare that solution set against the values of
#    the row, column, and box it belongs to, and eliminate those values from the solution set
# 3. When the program finds an empty cell, determine excluded_values in row, column, box
#    a. calculate values in row, add excluded_values to all_excluded values
#    b. calculate values in col, add excluded_values to all_excluded values
#    c. calculate values in box, add excluded_values to all_excluded values


# 4. If the solution set contains only 1 possible value, replace that value for the 0 placeholder of
#    that cell in the 81-character string
# 5. Continue through program loop until no remaining cells can be solved
# 6. If all characters in the 81-character string have been solved, print the completed board
# 7. If 1 or more characters in the 81-character string are unsolvable, return a statement notifying
#    the player that the current board is unsolvable using a logic-only algorithm

# CANDIDATE DATA STRUCTURES
# value_set = [1, 2, 3, 4, 5, 6, 7, 8, 9]
# ---
# single 81-char string
# ---
# array with nested hashes {key => value} for example {[0,0] => 3}
# ---
# another hash option: { 0: cell_object
#                        1: cell_object
#                        ...
#                        80: cell_object}




# class Cell
#   initialize(index_of_81)
#     @index_of_81
#     @x_coord = function(index_of_81)
#     @y_coord = function(index_of_81)
#     possible_values = [1,2,3,4,5,6,7,8,9]
#   end
# end

# object_0 = Cell.new(0)
# ---

class Sudoku
  attr_accessor :board, :candidates
  def initialize(board)
    @board = board.split("").map {|x| x.to_i}  # board in array format [6,1,9,0...2]
    @candidates = @board.map { |x| [x]}  # board as array of arrays [[6],[1],[9],[0]...[2]]
    @full_set = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def iterate_thru_candidates
    @candidates.each_with_index { |arr,index|
      if arr.length > 1 || arr[0] == 0
        @candidates[index] = candidates_for(index)
      end
    }
  end

  def get_row_indices(cell_index)
    row_indices = []
    9.times { |x| row_indices << (cell_index/9)*9 + x}
    row_indices
  end

  def get_col_indices(cell_index)
    col_indices = []
    9.times { |x| col_indices << (cell_index%9) + 9 * x }
    col_indices
  end

  def get_box_indices(cell_index)
    box_indices = []
    cell_row, cell_col = cell_index.divmod(9)
    box_row = cell_row/3
    box_col = cell_col/3
    home_row = box_row*3
    home_col = box_col*3
    home_cell_index = home_row*9 + home_col
    box_cell_indices = [ home_cell_index,
                         home_cell_index + 9,
                         home_cell_index + 18,
                         home_cell_index + 1,
                         home_cell_index + 1 + 9,
                         home_cell_index + 1 + 18,
                         home_cell_index + 2,
                         home_cell_index + 2 + 9,
                         home_cell_index + 2 + 18 ]
    9.times { |x| box_indices << (cell_index)   }
    box_cell_indices
  end

  def candidates_for(cell_index)
    excluded_values = []
    candidates = []
    row_indices = get_row_indices(cell_index)
    col_indices = get_col_indices(cell_index)
    box_indices = get_box_indices(cell_index)
    all_group_indices = (row_indices + col_indices + box_indices).uniq
    all_group_indices.each { |index|
      if @candidates[index].length == 1 && @candidates[index][0] != 0
        excluded_values << @candidates[index]
      end
      }
    excluded_values = excluded_values.uniq.select { |x| x != 0 }
    full_set_array_format = @full_set.map { |x| [x] }
    candidates = full_set_array_format - excluded_values
    candidates.flatten
  end

  def solve!
    solved = true
    100.times { iterate_thru_candidates } # brute force, but it's simple
    @candidates.each { |arr| (solved = false) if arr.length > 1 || arr[0] == 0 }
    if solved
      puts "Solved!"
      puts "Original board:"
      pretty_print_orig_board
      puts
      puts "      ---------------------------------------------"
      puts "Solved board:"
      pretty_print_candidates
      puts
    else
      puts "****** Can't solve this board:"
      pretty_print_orig_board
    end
    solved
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
  end

  def pretty_print(brd)
    board_string_array_w_formating = brd.map { |x| x.to_s.center(5)}
    puts "
    %s%s%s  %s%s%s  %s%s%s
    %s%s%s  %s%s%s  %s%s%s
    %s%s%s  %s%s%s  %s%s%s


    %s%s%s  %s%s%s  %s%s%s
    %s%s%s  %s%s%s  %s%s%s
    %s%s%s  %s%s%s  %s%s%s


    %s%s%s  %s%s%s  %s%s%s
    %s%s%s  %s%s%s  %s%s%s
    %s%s%s  %s%s%s  %s%s%s" % board_string_array_w_formating
  end

  def pretty_print_orig_board
    pretty_print(@board)
  end

  def pretty_print_candidates
    candidates_str = @candidates.map { |ar| ar.map { |d| d.to_s }.join }
    pretty_print(candidates_str)
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# board = File.readlines('sample.unsolved.txt').first.chomp
# game = Sudoku.new(board_string)

game1 = Sudoku.new('619030040270061008000047621486302079000014580031009060005720806320106057160400030')
game1.solve!
game2 = Sudoku.new('003020600900305001001806400008102900700000008006708200002609500800203009005010300')
game2.solve!