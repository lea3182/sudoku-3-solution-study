
#################
#  Sudoku R3    #
#################

#***********************
#* Hunter Chapman &&   *
#* Jake Persing        *
#* DBC Fence Lizards   *
#* bootcoder@gmail.com *
#* @bootcoder          *
#***********************


##################
# PSEUDO INITIAL #
##################

=begin
define a square class
  instance vars
    --row
    --col
    --box
    --value

  getter methods
  return object attributes

END CLASS

define sudoku class
  takes in a string as input at init
  init function
    vars
      --@string_input
      --@board
    call setter method for square population
  END FUNCTION

  METHOD LIST

  populate_sqaures
  guess
  solves
  display

  #populate_squares
    iterate through board string pushing values to new square objects
    1-d array populated by splitting string into an array of chars converted to ints
    create square objects that with square attributes
    split string convert to_i
    row, col = index_counter.divmod 9
    boxes 3(index_counter/27) + col/3
    assign value to each square
  END METHOD

  #guess
    define var known_value_array = []
    takes a single input from current square
    iterate over entire board,
    select all values if the current row matches the squares row and push to known_value_array
    iterate over board 3 times for r,c,b selecting all values that match squares r,c,b
    check for dups on push and negate
    when done known_value_array will have every squares value
    the goal is to go along and find if any space within r,c,b only needs a single number
    use array comparison on known_value_array VS: complete_array
    if there is only one missing val from comparison set val
    then move the fuck on

  #solve
    unless @board.square.value.include(0) == 0
      BOOYA
    iterate through board call guess at index of first 0
    calls guess
    call solve recursively

  #display board
    figure that shit out down the road
    EASY


=end

#################
#  INITAL CODE  #
#################

class Square
  attr_accessor :row, :col, :box, :value
  def initialize(row, col, box, value)
    @row = row
    @col = col
    @box = box
    @value = value
  end
end

class Sudoku
  attr_accessor :board, :board_string, :zero_counter
  def initialize(input)
    @board_string = input.split("")
    @board = []
    @numbers = %w{1 2 3 4 5 6 7 8 9}
    #@zero_counter = zero_value_count
    populate_squares
  end

  def populate_squares
    @board_string.each_with_index do |element, index|
      row = (index / 9)
      col = (index % 9)
      box = 3 * (index/27) + col/3
      @board << Square.new(row, col, box, element)
    end
  end

  def guess?(square)
    known_values_array = []
    @board.each_with_index do |element, indx|
      known_values_array << element.value if element.row == square.row
      known_values_array << element.value if element.col == square.col
      known_values_array << element.value if element.box == square.box
    end
    diff = @numbers - known_values_array.uniq!
    #p "length:#{known_values_array.length} diff:#{@numbers - known_values_array}"
    square.value = diff[0] if diff.length == 1
  end

  def solve!
    unless zero_value_count == 0
      @board.each_with_index do |square,index|
        guess?(square) if square.value == "0"
      #puts "after return zvc=#{zero_value_count}"
      end
      solve!
    end

  end

  def display
    @board.each_with_index do |element,i|
      puts "\n" if i % 9 == 0
      print " #{element.value} "
    end
    puts
  end

  def square_audit
    @board.each_with_index do |el,i|
      puts "Square #{i}: row: #{el.row} col: #{el.col} box: #{el.box} value: #{el.value}"
    end
  end

  def zero_value_count
    zero_counter = 0
    @board.each do |element|
      #p element.value
      zero_counter+=1 if element.value == "0"
    end
    zero_counter
  end

  def solved?
    return puts "\nBOOYA\n\n" if zero_value_count == 0
    puts "Sad face..."
  end



end


###################
# REFACTORED CODE #
###################

# method to display all squares in given r,c,b

#################
#  DRIVER CODE  #
#################


#################
# ASSERT / TEST #
#################
#
# easy works // harder,,, not so much.
#
easy_game = Sudoku.new('619030040270061008000047621486302079000014580031009060005720806320106057160400030')
harder_game = Sudoku.new("030500804504200010008009000790806103000005400050000007800000702000704600610300500")
#easy_game.board
#easy_game.square_audit
#easy_game.guess?
easy_game.display
easy_game.solve!
easy_game.display
easy_game.solved?
#easy_game.display
#harder_game.solve!
#harder_game.display
