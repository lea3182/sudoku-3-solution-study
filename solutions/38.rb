# require 'debugger'

class Sudoku
  attr_accessor :potential_solutions, :board
  attr_reader :rows, :columns, :grids

  def initialize(board_string)
    @board = board_string.chars.map(&:to_i)
    @rows = make_rows(board)
    @columns = make_columns
    @grids = make_grids
    @potential_solutions = []
  end

  def make_rows(board)
    board_ary = board.dup
    nested = []
    9.times { nested << board_ary.shift(9) }
    nested
  end

  def make_columns
    @rows.transpose
  end

  def make_grids
    all_grids = []
    grid = []
    sets = [[0,1,2],[3,4,5],[6,7,8]]
    sets.each do |set|
      3.times do |x|
        grid << @rows[x][(set.first)..(set.last)]
      end
    end
    sets.each do |set|
      3.times do |x|
        grid << @rows[x+3][(set.first)..(set.last)]
      end
    end
    sets.each do |set|
      3.times do |x|
        grid << @rows[x+6][(set.first)..(set.last)]
      end
    end
    grid.flatten!
    9.times { all_grids << grid.shift(9) }
    all_grids
  end

  def one_to_nine
    (1..9).to_a
  end

  def get_coord_for(cell_index)
    coord = [((cell_index - 1) / 9), ((cell_index - 1) % 9)]
  end

  def get_grid_for(cell_index)
    coords = get_coord_for(cell_index)
    (coords[0]/3)*3 + (coords[1]/3)
  end

  def digit_search(cell_index)
    @potential_solutions = []
    coords = get_coord_for(cell_index)
    row = coords[0]
    col = coords[1]
    grid = get_grid_for(cell_index)
    one_to_nine.each do |x|
      if !(@rows[row].include?(x)) && !(@columns[col].include?(x)) && !(@grids[grid].include?(x))
        @potential_solutions << x
      end
    end
    @potential_solutions
  end

  def solve
    really_solve(@board)
  end

  def really_solve(board)
    # p board
    return board if !(board.include?(0))
    @rows = make_rows(board)
    @columns = make_columns
    @grids = make_grids
    current_board = board.map.with_index do |cell, index|
      if cell == 0
        solutions = digit_search(index)
        cell = solutions.first if solutions.length == 1
        cell
      else
        cell
      end
    end
    p current_board
    really_solve(current_board)
  end

  # Returns a string representing the current state of the board
  def to_s
    # @rows.join("\n")
  end
end

# DRIVER
sudoku = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")
p sudoku.board
# p sudoku.get_coord_for(81)
# p "These are rows!!!"
# p sudoku.rows
# p "These are columns!!!"
# p sudoku.columns
# p "These are grids!!!"
# p grids = sudoku.grids
# puts "-" * 50
# p sudoku.solve
p sudoku.get_coord_for(12)
p sudoku.digit_search(12)
p sudoku.board[0,12]

p sudoku.get_coord_for(23)
p sudoku.digit_search(23)
p sudoku.board[0,23]

