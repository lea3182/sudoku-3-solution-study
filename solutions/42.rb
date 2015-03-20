require 'debugger'

class Sudoku
  attr_accessor :potential_solutions

  def initialize(board_string)
    @board = board_string
    @rows = rows
    @columns = columns
    @grids = grids
    @potential_solutions = []
  end

  def rows
    rows = []
    ary = nested_board.flatten
    9.times do
      rows << Array.new(ary.shift(9))
    end
    rows
  end

  def columns
    rows.transpose
  end

  def grids
    grid1 = []
    grid2 = []
    grid3 = []
    grid4 = []
    grid5 = []
    grid6 = []
    grid7 = []
    grid8 = []
    grid9 = []
    grids = []
    # 3.times do |y|
      3.times do |x|
        grid1 << @rows[x][0..2]
        grid1.flatten!
      end
      3.times do |x|
        grid2 << @rows[x][3..5]
        grid2.flatten!
      end
      3.times do |x|
        grid3 << @rows[x][6..8]
        grid3.flatten!
      end

      3.times do |x|
        grid4 << @rows[x+3][0..2]
        grid4.flatten!
      end
      3.times do |x|
        grid5 << @rows[x+3][3..5]
        grid5.flatten!
      end
      3.times do |x|
        grid6 << @rows[x+3][6..8]
        grid6.flatten!
      end

      3.times do |x|
        grid7 << @rows[x+6][0..2]
        grid7.flatten!
      end
      3.times do |x|
        grid8 << @rows[x+6][3..5]
        grid8.flatten!
      end
      3.times do |x|
        grid9 << @rows[x+6][6..8]
        grid9.flatten!
      end

    # end
    grids << grid1
    grids << grid2
    grids << grid3
    grids << grid4
    grids << grid5
    grids << grid6
    grids << grid7
    grids << grid8
    grids << grid9

    grids
  end

  def nested_board
    board_ary = @board.chars
    nested = []
    9.times { nested << board_ary.shift(9) }
    nested
  end

  def get_coordinate_for(cell_index)
    board_ary = @board.chars
    nested_board.each_with_index do |row, index|
      y = row.index(board_ary[cell_index])
      return index, y if y
    end
  end

  def get_grid_for(cell_index)
    indices = {
    1 => [0, 1, 2, 9, 10, 11, 18, 19, 20],
    2 => [3, 4, 5, 12, 13, 14, 21, 22, 23],
    3 => [6, 7, 8, 15, 16, 17, 24, 25, 26],
    4 => [27, 28, 29, 36, 37, 38, 45, 46, 47],
    5 => [30, 31, 32, 39, 40, 41, 48, 49, 50],
    6 => [33, 34, 35, 42, 43, 44, 51, 52, 53],
    7 => [54, 55, 56, 63, 64, 65, 72, 73, 74],
    8 => [57, 58, 59, 66, 67, 68, 75, 76, 77],
    9 => [60, 61, 62, 69, 70, 71, 78, 79, 80]
    }
    hash = indices.select {|k,v| v.include?(cell_index) }
    hash.keys.first
  end

  def digit_search(cell, num)
    board_ary = @board.chars
    coords = get_coordinate_for(board_ary.index(cell))
    # coords = [1, 3]
    row = coords[0]
    col = coords[1]
    grid = get_grid_for(board_ary.index(cell))
    return @potential_solutions if num == 10
    if @rows[row].include?(num.to_s) == false && @columns[col].include?(num.to_s) == false && @grids[grid].include?(num.to_s) == false
      @potential_solutions << num.to_s
      digit_search(cell, num+1)
    else
      digit_search(cell, num+1)
    end
    @potential_solutions
  end

  def solve
    board_ary = @board.chars
    final = board_ary.map do |cell|
      if cell == "-"
        solutions = digit_search(cell, 1)
        if solutions.length == 1
          cell = solutions.first
          @potential_solutions = []
        else
          cell
        end
      else
        cell
      end
    end
    final
  end

  def board
    nested_board
  end

  # Returns a string representing the current state of the board
  def to_s
  end
end

# DRIVER
sudoku = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")
# p sudoku.nested_board.flatten
# p "---------------------"
p sudoku.nested_board
p "---------------------"
p sudoku.solve
# p sudoku.get_grid_for(77)

