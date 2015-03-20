
require 'debugger'

 class Sudoku
   def initialize(board_string)
    @board = board_string.split('')
    @board = Array.new(9) {@board.shift(9)}
    @coordinates = {}
    @board_solved = false
    @key_index = 0
   end

  def solve
    eliminate_possibilites
  end

  def eliminate_possibilites
    beginning_blanks = total_blanks
    0.upto(8) do |row|
      0.upto(8) do |col|
        if @board[row][col] == "-"
          possible_solutions = []
          1.upto(9) do |evaluator|
            unless is_unavailable?(evaluator, row, col)
              possible_solutions << evaluator.to_s
            end
          end
          if possible_solutions.length == 1
            @board[row][col] = possible_solutions[0]
          else
            @coordinates[[row,col]] = possible_solutions
          end
        end
      end
    end
    check_if_solved(beginning_blanks)
  end

  def find_unique_possibility
    beginning_blanks = total_blanks
    unsolved_coords.each do |coord|
      @current_coord_solved = false
      break unless @coordinates.include?(coord) || @board[coord[0]][coord[1]] == "-"
      possible_values = @coordinates[coord]

      row_coords = unsolved_coords.select {|c| c[0] == coord[0]}
      check_unique(possible_values, row_coords, coord)
      break if @current_coord_solved


      col_coords = unsolved_coords.select {|c| c[1] == coord[1]}
      check_unique(possible_values, col_coords, coord)
      break if @current_coord_solved

      grid_coords = unsolved_coords.select { |c| grid_indices(coord[0],coord[1]).include?(c) }
      check_unique(possible_values, grid_coords, coord)
    end

    check_if_solved(beginning_blanks)

  end

  def check_if_solved(blanks)
    @board_solved = true if total_blanks == 0
    return if blanks == total_blanks

    find_unique_possibility
  end

  def check_unique(possible_values, coords, current_coords)
    possible_values.each do |val|
      #Check to see if the value is still possible (could occur if a column, row, or grid coordinate was filled later)
      if is_unavailable?(val,current_coords[0],current_coords[1])
        @coordinates[current_coords].delete(val)
        break
      end
      unique = 0

      coords.each do |coord|
        state = @coordinates[coord].include?(val)
        if state
          unique += 1
        end
        break if unique > 1
      end

      if unique == 1
        @board[current_coords[0]][current_coords[1]] = val
        @coordinates[current_coords] = [val]
        @current_coord_solved = true
      end
      break if unique == 1
    end
  end

  def is_unavailable?(evaluator, row, col)
    evaluator = evaluator.to_s
    @board[row].include?(evaluator) || @board.transpose[col].include?(evaluator) || current_grid(row,col).include?(evaluator)
  end

  def current_grid(row, col)
    sets = [[0,1,2],[3,4,5],[6,7,8]]
    gridrows = []
    gridcols = []
    sets.each do |trio|
      gridrows = trio if trio.include?(row)
      gridcols = trio if trio.include?(col)
    end

    grid = []
    gridrows.each do |row|
      gridcols.each do |col|
        grid << @board[row][col]
      end
    end
    grid
  end

  def grid_indices(row, col)
    sets = [[0,1,2],[3,4,5],[6,7,8]]
    gridrows = []
    gridcols = []
    sets.each do |trio|
      gridrows = trio if trio.include?(row)
      gridcols = trio if trio.include?(col)
    end

    grid = []
    gridrows.each do |row|
      gridcols.each do |col|
        grid << [row,col]
      end
    end
    grid
   end

  def board
    to_s
  end

  def guess(index)
    stored_board = @board.dup
    stored_hash = @coordinates.dup
    current_coord = hash_keys[index]

    @coordinates[current_coord].each do |possibility|
      @board[current_coord[0]][current_coord[1]] = possibility
      @coordinates[current_coord] = possibility
      find_unique_possibility
    end

  end

  def unsolved_coords
    @coordinates.keys
  end

  #Once we played the number, is the row, column, and grid valid
  def puzzle_valid?(val,row,col)
    valid_set?(@board[row],val) && valid_set?(@board.transpose[col],val) && valid_set?(current_grid(row,val),val)
  end

  #Does our given row, column, or grid contain a duplicate of an element?
  def valid_set?(set,val)
    set.count {|element| element == val} == 1
  end



  def total_blanks
    dashes = 0
    @board.each {|row| dashes += row.count("-") }
    dashes
  end

   # Returns a string representing the current state of the board
  def to_s
    output = ""
    @board.each { |row| output += row.join('') + "\n" }
    output
  end
 end

# game = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--
# # ")
# p game.valid_set?(["1","1","-","2","3","9","2","-"],"3")
