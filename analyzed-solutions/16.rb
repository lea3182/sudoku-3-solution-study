# Pseduocode
# Input: string of 81 integers between 0-9, where 0 = empty cell
# Output: solved Sudoku puzzle
# Steps:
# 1. Define initial board as an array of 81 characters
# 2. Loop thru the array and find the first empty cell (value = 0)
# 3. For empty cell, identify the row, column, and box
# 4. For each row, column, and box, checking the following
# => determine possible values for empty cell
# => Do Step 4 for column and box
# => See if there is a unique value for empty cell
# => if so, fill empty cell
# => if not, go the next empty cell
# => continue until all empty cells are filled

class Sudoku
  def initialize(board_string)
    @board_string = board_string
    @sudoku_board = board_string.split('')
    @initial_index = 0
    @possible_values = %w(1 2 3 4 5 6 7 8 9)
  end

  def get_row(number_index)
    current_row = number_index/9 #current row

    row_values = []

    @sudoku_board.each_index do |index|
      if current_row == index/9
        row_values << @sudoku_board[index]
      end
    end

    possible_array = @possible_values - row_values

  end

  def get_col(number_index)
    current_column = number_index % 9 # current column

    col_values = []

    @sudoku_board.each_index do |index|
      if current_column == index % 9
        col_values << @sudoku_board[index]
      end
    end

    possible_array = @possible_values - col_values

    # p possible_array
    # @sudoku_board.each_index {|index| puts "number #{@sudoku_board[index]} is on column #{(index%3)+1}"}
    # n = @sudoku_board.each_index {|index| (index % 3)+1 }
    # col 0 => value 0, 9, 18, 27, 36, 45, 54, 63, 72
    # col 1 => value 1, 10, 19, 28, 37, 46, 55, 64, 73
    #.....
    # col 8 => value 8, 17, 26, 35, 44, 53, 62, 71, 80
  end

  def get_box(number_index)
    current_box = ((number_index / 27) * 3) + (number_index % 9)/3

    box_values = []

    @sudoku_board.each_index do |index|
      if current_box == ((index / 27) * 3) + (index % 9)/3
        box_values << @sudoku_board[index]
      end
    end

    possible_array = @possible_values - box_values

  end

  def unsolved?
    @sudoku_board.include?("0")
  end

  def solve!
# Steps:
# 1. Define initial board as an array of 81 characters
# 2. Loop thru the array and find the first empty cell (value = 0)
# 3. For empty cell, identify the row, column, and box
# 4. For each row, column, and box, checking the following
# => determine possible values for empty cell
# => Do Step 4 for column and box
# => See if there si a unique value for empty cell
# => if so, fill empty cell
# => if not, go the next empty cell
# => continue until all empty cells are filled
    num_changes = 1

    while unsolved? && num_changes >= 1
      num_changes = 0
      for index in 0..80
        if @sudoku_board[index] == "0"
          row_possible_values = get_row(index)
          col_possible_values = get_col(index)
          box_possible_values = get_box(index)

          # possible values
          combined_total_values = row_possible_values & col_possible_values & box_possible_values

          if combined_total_values.count == 1
            @sudoku_board[index] = combined_total_values[0] # found value
            num_changes += 1
          end
        end

      end
    end

  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    @sudoku_board.each_slice(9) {|row| puts row.join}

  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# sample_small_string = "619030040270061008000047621486302079000014580031009060005720806320106057160400030"
# game = Sudoku.new(sample_small_string)
# board_string = File.readlines('set-01_sample.unsolved.txt').first.chomp
# game = Sudoku.new(board_string)
File.readlines('set-01_sample.unsolved.txt').each_with_index do |puzzle, index|
  game = Sudoku.new(puzzle)

  # Remember: this will just fill out what it can and not "guess"
  game.solve!
  puts "Sudoku Solved for Puzzle #{index+1}"

  game.board
end