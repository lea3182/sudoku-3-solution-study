# Release 0 - Modeling
# Setter - person who created the puzzle
# Player - person who is solving the puzzle
# What strategies are you adopting and why?

# How do you choose where to start?
  # I choose to start in the areas that are closest to completion
# How do you know when to really put a number in a cell?
  # When it is the ONLY number that can go there, not just a possible number.
# Did you adopt the same notation/board markings while playing Sudoku? Why? If not, why did you choose differently?
# Are you avoiding any strategies because they're too tedious or require you to remember too much?
# Yes, if there are too many options for a cell can be, I won't write them all down until later.

# Each cell will be either filled or blank.
  # If the cell is blank, it has a list of numbers that it could possibly be.
  # This list is populated by looking at the numbers in the row and column and box and taking ^.

# Create the board
# Accept a string of numbers as input
# Convert the string into an array
# Take the first 9 digits and set it equal to the first row. Do this for the next 8 rows as well.

class Cell
  attr_accessor :value, :row, :col, :box, :possible_values

  def initialize(num, row, col)
    @value = num.to_i
    @row = row
    @col = col
    @numbers = (1..9).to_a
  end

  def box
    if row < 3 && col <3
      1
    elsif row <3 && col < 6
      4
    elsif row <3 && col <9
      7
    elsif row <6 && col <3
      2
    elsif row <6 && col <6
      5
    elsif row <6 && col <9
      8
    elsif row <9 && col <3
      3
    elsif row <9 && col <6
      6
    else
      9
    end
  end

  def set?
    @value != 0
  end

end

class Sudoku
  attr_accessor = :board

  def initialize(board_string)
    input = board_string.split("")
    @board = Array.new(9) {input.shift(9)}
    @numbers = (1..9).to_a
    convert_to_cell_object
    @solved = false
  end

  def convert_to_cell_object
    @board.each_with_index do |row, row_num|
      row.each_with_index do |cell, col_num|
        @board[row_num][col_num] = Cell.new(cell, row_num, col_num)
      end
    end
  end

  def board
    output =  "-"*29
    @board.each_with_index do |row, index|
      output += "\n"

      row.each_with_index do  |cell, col_index|
        output += " #{cell.value} "

        if col_index == 2 || col_index == 5
          output += "|"
        end

      end

      if (index+1)%3 == 0
        output += "\n" + "-"*29
      end

    end
    output
  end

  def solve!
    fill_board

    # Guess: Find a cell that has only 2 values. Pick the first value and create a new board with that value set.  Then, run solve on this new board until it either a. needs to guess again or b. breaks.
    # If a. , guess again until it either a. needs to guess again or b. breaks ( recursive)
    # If b., go up one level of guessing, and guess the next number.
  end

  def fill_board
    changed = false
    while true
      changed = false
      @board.each do |row|
        row.each do |cell|
          if !cell.set?
            possible_values = find_possible_values(cell)
            # puts "Cell is #{cell.row}, #{cell.col}."
            # puts self.board
              if possible_values.length == 1
                cell.value = possible_values[0]
                changed = true
              end
          end
        end # row.each
      end # board.each
      break if changed == false
    end #until true

  end

  def guess
    # hold the current state of the board
    #find a cell with only 2 values
      #set the cell's value to the first value
    #try to fill the guessing board.
    # if the fills up, you are done.
    # if not

  end

  def find_possible_values(cell)
    possible_values = []
    if !cell.set?
      possible_values = @numbers - get_row(cell.row) - get_col(cell.col) - get_box(cell.box)
      # p "loc: #{cell.row}, #{cell.col}, poss values are #{possible_values}"
    end
    cell.possible_values = possible_values
  end

  def get_row(row_num)
    row = []
    @board[row_num].each do |cell|
      row << cell.value
    end
    row
  end

  def get_col(col)
    column = []
    @board.each do |row|
      row.each do |cell|
        column << cell.value if cell.col == col
      end
    end
    column
  end

  def get_box(box_num)
    box = []
    @board.each do |row|
      row.each do |cell|
        box << cell.value if cell.box == box_num
      end
    end
    box
  end

  def check_row(row)
    @numbers.all? { |num| @board[row].include?(num) }
  end

  def check_col(col)
    @numbers.all? { |num| get_col(col).include?(num) }
  end

  def check_box(box_num)
    @numbers.all? { |num| get_box(box_num).include?(num) }
  end

end

 # game = Sudoku.new("609238740274561398803947621486352179792614583531879264945723816328196457167485932")
# game = Sudoku.new('619030040270061008000047621486302079000014580031009060005720806320106057160400030')

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('set-01_sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

puts game.board
game.solve!
puts game.board

# Tests:
# Each Row, Column, and box should have the digits 1-9 only once

# def assert_rows(game)
#   raise "Rows did not pass" unless game.check_rows
# end

# assert_rows(game)