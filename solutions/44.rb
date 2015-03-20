
require 'debugger'

 class Sudoku
   def initialize(board_string)
    @board = board_string.split('')
    @board = Array.new(9) {@board.shift(9)}
    @coordinates = {}
    @board_solved = false
    @contradiction = false
    @started_guessing = false
    @test = 0
    @guesses = {}
   end

  def solve
    eliminate_possibilites
    p "test: #{@test}"
    p @board
    p @coordinates
    p @guesses
  end

  def eliminate_possibilites
    begin
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
              puts "placing #{possible_solutions[0]} at [#{row},#{col}]"
            else
              @coordinates[[row,col]] = possible_solutions
              puts "creating a hash for [#{row},#{col}] with values #{possible_solutions}"
            end
          end
        end
      end
    end until beginning_blanks == total_blanks
    find_unique_possibility
  end

  def find_unique_possibility
    begin
    beginning_blanks = total_blanks
      unsolved_coords.each do |coord|

        @current_coord_solved = false
        next unless @coordinates.include?(coord)
        # next if @coordinates[coord].length < 2
        possible_values = @coordinates[coord]

        row_coords = unsolved_coords.select {|c| c[0] == coord[0]}
        check_unique(possible_values, row_coords, coord)
        next if @current_coord_solved


        col_coords = unsolved_coords.select {|c| c[1] == coord[1]}
        check_unique(possible_values, col_coords, coord)
        next if @current_coord_solved

        grid_coords = unsolved_coords.select { |c| grid_indices(coord[0],coord[1]).include?(c) }
        check_unique(possible_values, grid_coords, coord)
      end

    end until beginning_blanks == total_blanks

    @board_solved = true if total_blanks == 0

    guess(0) unless @started_guessing || @board_solved
  end


  def guess(index)
    @started_guessing = true
    current_coord = unsolved_coords[index]
    @test += 1

    @coordinates[current_coord].each do |possibility|
      debugger
      #Does the given key already have a value
      break if @coordinates[current_coord].length < 2
      @guesses[current_coord] = possibility
      #Store a current version of board and hash
      stored_board = deep_copy(@board.dup)
      stored_hash = @coordinates.dup
      #Make our guess by placing the number on the board and replacing our possibilities with only one item
      @board[current_coord[0]][current_coord[1]] = possibility

      @coordinates[current_coord] = [possibility]
      # debugger
      p "placing #{possibility} on the board at #{current_coord}"
      #Try to solve the puzzle
      find_unique_possibility

      # debugger
      if @contradiction
        debugger
        @board = stored_board
        @coordinates = stored_hash
        @contradiction = false
        next
      else
        guess(index+1)
        debugger
      end
      guess(index+1)
      return if @board_solved

    end
    find_unique_possibility unless total_blanks == 0
  end

  def check_if_solved(blanks)
    return @board_solved = true if total_blanks == 0
    return if total_blanks == blanks
    find_unique_possibility #unless blanks == total_blanks
    return if @contradiction



  end

  def check_unique(possible_values, coords, current_coords)
    row = current_coords[0]
    col = current_coords[1]

    @current_coord_solved = true if possible_values.length == 1
    possible_values.each do |val|
      possible_values
      #Check to see if the value is still possible (could occur if a column, row, or grid coordinate was filled later)
      if is_unavailable?(val,row,col)
        puts "deleting #{val} from #{current_coords}"
        @coordinates[current_coords].delete(val)
        if @coordinates[current_coords].length == 0
          @contradiction = true
          return
        end
        next
      end
      unique = 0

      coords.each do |coord|
        state = @coordinates[coord].include?(val)
        if state
          unique += 1
        end
        next if unique > 1
      end

      if unique == 1
        @board[row][col] = val
        # @coordinates[current_coords] = [val]
        @coordinates.delete(current_coords)
        puts "placing #{val} at [#{row},#{col}]"
        # puts "new value for the key #{current_coords} is #{@coordinates[current_coords]}"
        @current_coord_solved = true

        #We need to check if we found a contradiction when we placed the number here
        break if puzzle_valid?(val,row,col)
        debugger
        #if it was not valid, then we had a contradictory placement
        @contradiction = true
        break
      end
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



  def unsolved_coords
    @coordinates.keys
  end

  #Once we played the number, is the row, column, and grid valid
  def puzzle_valid?(val,row,col)
    valid_set?(@board[row],val) && valid_set?(@board.transpose[col],val) && valid_set?(current_grid(row,col),val)
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

 def deep_copy(o)
  Marshal.load(Marshal.dump(o))
 end

# game = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--
# # ")
# p game.valid_set?(["1","1","-","2","3","9","2","-"],"3")
