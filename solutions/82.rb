
class Sudoku
  attr_reader :cells

  def initialize(board_string)
    values = board_string.split('')
    @cells = values.map.with_index do |num_string, index|
      Cell.new(num_string.to_i, index, self)
    end
  end

  def solve!
    until empty_cells.empty?
      empty_cells.each do |cell|
        if cell.compute_possible_values.length == 1
          cell.value = cell.possible_values.first
        end
      end
    end
  end

  def empty_cells
    @cells.select {|cell| cell.value == 0}
  end

  def board
    string_values = @cells.map {|cell| cell.value.to_s }
    string_arrays = Array.new(9) { string_values.shift(9) }
    string_arrays.each { |array| puts array.join(' ')}
  end
end


class Cell
  attr_accessor :value
  attr_reader :row, :column, :box, :possible_values

  def initialize(value, index, game)
    @value = value
    @row, @column = index.divmod(9)
    @box = [@row / 3, @column / 3]
    @possible_values = (1..9).to_a
    @game = game
  end

  def compute_possible_values
    @possible_values -= invalid_values
  end

  def invalid_values
    composite_array_of_constraints = (get_values("row") + get_values("column") + get_values("box"))
    composite_array_of_constraints.uniq.select {|value| value != 0 }
  end

  def get_values(area)
    already_filled_cells = @game.cells.select do |other_cell|
      other_cell.send(area) == instance_variable_get("@#{area}")
    end
    already_filled_cells.map {|filled_cell| filled_cell.value}
  end
end


#----------------------------------------------------------------------
# LETS SEE SOME TESTS

all_test_strings = File.readlines('sample.unsolved.txt').map {|line| line.chomp}
simple_test_strings, complex_test_strings = all_test_strings.shift(8), all_test_strings

simple_test_strings.each do |input_string|

  game = Sudoku.new(input_string)
  game.solve!
  game.board
  puts "-----------------"
end