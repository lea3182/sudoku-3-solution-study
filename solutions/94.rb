#require 'debugger'

class Cell
  attr_accessor :value, :possible_values
  attr_reader  :index, :row_id, :col_id, :box_id

  def initialize(value, index)

## Boxes. What's the formula for this??
    b1 = [0,1,2,9,10,11,18,19,20]
    b2 = b1.map { |cell| cell + 3 }
    b3 = b2.map { |cell| cell + 3 }
    b4 = b1.map { |cell| cell + 27 }
    b5 = b2.map { |cell| cell + 27 }
    b6 = b3.map { |cell| cell + 27 }
    b7 = b1.map { |cell| cell + 54 }
    b8 = b2.map { |cell| cell + 54 }
    b9 = b3.map { |cell| cell + 54 }
    @box_array = [b1,b2,b3,b4,b5,b6,b7,b8,b9]
 ##
 ### Important cell attributes
    @value = value
    @index = index
    @row_id = index/9
    @col_id = index%9
    @box_id = @box_array.index(@box_array.select { |box| box.include?(index) }.flatten)
    @possible_values = []
  end

end

class Sudoku

  attr_reader :options, :board

  def initialize(board_string)
      @board_string = board_string.split(//).map { |s| s.to_i }
      @options = (1..9).to_a
      @board = @board_string.map.with_index { |value,index| Cell.new(value,index) }
  end

  def get_possible_values(current_cell)
    current_cell.possible_values = []

    related_cells =
      @board.select { |cell| cell.row_id == current_cell.row_id } +
      @board.select { |cell| cell.col_id == current_cell.col_id } +
      @board.select { |cell| cell.box_id == current_cell.box_id }

    related_values =
      related_cells.map { |cell| cell.value }

    current_cell.possible_values = (@options - (related_values.uniq - [0]))

  end

  def no_more_empties
    @board.select { |cell| cell.value == 0 }.empty?
  end

  def solve!
    until no_more_empties
      @board.each do  |cell|
        possible_values = get_possible_values(cell)
        if cell.value == 0 && possible_values.length == 1
            cell.value = possible_values[0]
        end
      end
    end
    board
  end

  def board
    puts "solved!"
    @board.each_slice(9) do |cells|
     p cells.map { |cell| cell.value }
    end
  end

end

test = Sudoku.new("609238745274561398853947621486352179792614583531879264945723816328196457167485932")
test.solve!
puts
puts
test = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
test.solve!
puts
puts
test = Sudoku.new("005030081902850060600004050007402830349760005008300490150087002090000600026049503")
test.solve!
puts
puts
test = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
test.solve!
puts
puts
test = Sudoku.new("005030081902850060600004050007402830349760005008300490150087002090000600026049503")
test.solve!
