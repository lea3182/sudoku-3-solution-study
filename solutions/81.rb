=begin
PSUEDOCODE

I. PREPARE BOARD
  A. BREAK STRING UP BY CHARACTER
    a. change to integer
    b. and send each integer and index into cell intialize
    c. push each cell into instance array @cells

II. INITIALIZE CELL
  A. Take index and value
  B. Set value to instance variable and readear _writer attribute
  C. Convert Index into Row Column
      a. @row, @col = index.divmod(10)
  D. Define box using method
  E. Create Possible Values

III. SOLVE METHOD

  GET EMPTY CELLS (Within Solve Method)
    a. Select from cells array all cells that have value of 0 and push to Empty
    cells Array

  CHECK EMPTY CELLS LENGTH:

  IF EMPTY CELLS LENGTH GREATER THAN 0 THEN ITERATE THROUGH EMPTY CELLS ARAY IN STEPS IV and V:

    IV. FOR FIRST EMPTY CELL: CHECK CORRESPONDING SETS
      A. Get Row of Cell
        a. return array of all values from cells in Cells Array that have same Row
      B. Get Column of Cell
        a. return array of all values from cell in Cells Array that have same column
      C. Get Box of Current Cell
        a. reteurn array of all values from cells in Cells Array that have same box
      D. Modify array permenantly by Subtracting all return arrays from the Current Cell's Possible Values
      E. Retrun array of possible values

    V. Check if box has single solution
        A. YES: SINGLE SOLUTION: Return Answer
          a. if length of array equals 1 then set value to possible_values[0]
        B. NO: MULTIPLE SOLUTIONS: Move cell and Return to II

  IF EMPTY CELLS ARRAY LENGTH EQUALS 0

  Return Board as sting and print board.

CLASSES:

SUDOKU

Instance Variables:
Board: array of Cell objects

Methods:

Empty Cells: Returns all cells from Board that are empty
Solve:
  1.Select all Empty Cells
  2. Iterate through empty cell array
  3. Solve Cell.
    a.If Solve Select go back to 1
    b. If not solve go iterate to next cell in empty cells array and repeat this step
  4. Iterate through Solve until Empty cells array length == 0 and return board



CELL
Arguments(index,value)

Methods:
  Row? Method(takes index or coordinates for cell) returns row number
  Column? Method(take index or coordinates) return column number
  Box? Method (take index or coordinates) return box number
  Possible Values:
  Not Possible Values**

Attribute Reader Writer:
  Value
  Possible Values
  Not Possible **
  Row, Column, Box
  Coordinates

=end

class Sudoku
  attr_reader :cells

  def initialize(board_string)
    values = board_string.split('')
    @cells = values.map.with_index {|num_string, index| Cell.new(num_string.to_i, index, self)}
  end

  def solve!
    while empty_cells?
      @cells.each do |cell|
        if cell.possible_values.length == 1 && cell.value == 0
        cell.value = cell.possible_values[0]
        end
      end
    end

   end

  def empty_cells?
    @cells.any? {|cell| cell.value == 0}
  end

  def return_
    string_result = ""
    @cells.each{ |cell| string_result += cell.value.to_s }
    string_result
  end

  def board
    string_values = return_.split('')
    string_arrays = Array.new(9) { string_values.shift(9) }
    string_arrays.each { |array| puts array.join(' ')}
  end
end

class Cell
  attr_accessor :value, :possible_values
  attr_reader :row, :column, :box_id, :game

  def initialize(value, index, game)
    @value = value
    @row, @column = index.divmod(9)
    @box_id = [@row / 3, @column / 3]
    @possible_values = (1..9).to_a
    @game = game
  end

  def possible_values
    @possible_values = @possible_values - get_invalid_values
  end

  def get_invalid_values
    (get_row_values + get_column_values + get_box_id_values).uniq.delete_if { |value| value == 0}
  end

  def get_row_values
    @game.cells.select {|other_cell| other_cell.row == @row}.map {|other_cell| other_cell.value}
  end

  def get_column_values
    @game.cells.select {|other_cell| other_cell.column == @column}.map {|other_cell| other_cell.value}
  end

  def get_box_id_values
     @game.cells.select {|other_cell| other_cell.box_id == @box_id}.map {|other_cell| other_cell.value}
  end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
#board_string = File.readlines('sample.unsolved.txt').first.chomp

#game = Sudoku.new(board_string)


  test1 = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
  test1.solve!
  test1.board

puts " ------------------------------------------------- "

  test2 = Sudoku.new("005030081902850060600004050007402830349760005008300490150087002090000600026049503")
  test2.solve!
  test2.board

puts " ------------------------------------------------- "

  test3 = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
  test3.solve!
  test3.board

puts " ------------------------------------------------- "

  test4 = Sudoku.new("005030081902850060600004050007402830349760005008300490150087002090000600026049503")
  test4.solve!
  test4.board

puts " ------------------------------------------------- "
  test5 = Sudoku.new("290500007700000400004738012902003064800050070500067200309004005000080700087005109")
  test5.solve!
  test5.board

puts " ------------------------------------------------- "
  test6 = Sudoku.new("080020000040500320020309046600090004000640501134050700360004002407230600000700450")
  test6.solve!
  test6.board

puts " ------------------------------------------------- "
  test7 = Sudoku.new("608730000200000460000064820080005701900618004031000080860200039050000100100456200")
  test7.solve!
  test7.board

puts " ------------------------------------------------- "
  test8 = Sudoku.new("370000001000700005408061090000010000050090460086002030000000000694005203800149500")
  test8.solve!
  test8.board
# Start of Second Level Tests
# puts " ------------------------------------------------- "
#   test9 = Sudoku.new("000689100800000029150000008403000050200005000090240801084700910500000060060410000")
#   test9.solve!
#   test9.board
