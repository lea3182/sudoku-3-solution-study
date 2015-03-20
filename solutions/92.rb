
class Cell
  attr_accessor :value
  attr_reader :index, :possible_values, :row_id, :col_id, :box_id

  def initialize(value, index)
    @value = value
    @index = index
    @options = (1..9).to_a
    @row_id = index/9
    @col_id = index%9
    @box_id = ((@row_id / 3) * 3) + (@col_id / 3)
  end

  def refresh_possible_values(array)
    # Takes the current possible values, removes the ones given as the argument
    @row_values = array.map {|object| object.value if object.row_id == @row_id}
    @col_values = array.map {|object| object.value if object.col_id == @col_id}
    @box_values = array.map {|object| object.value if object.box_id == @box_id}

    @possible_values = @options - (@row_values + @col_values + @box_values)
  end

  def to_s
    @value
  end

end


class Sudoku

  attr_reader :cell_array

  def initialize(board_string)
    @board_string = board_string.split(//).map { |s| s.to_i }
    @cell_array = @board_string.map.with_index do |value,index|
      test = Cell.new(value,index)
    end
  end

  #METHOD
  # Refresh all possible values
  #
  # For each cell of the array, select every other cell in the same row, column, and box
  # Select their values
  # pass them to the cell so that the cell refreshes its possible values

  def solve!

    until solved?


      @cell_array.each do |cell_object|
        cell_object.refresh_possible_values(@cell_array)
        if cell_object.value == 0 && cell_object.possible_values.length == 1
            cell_object.value = cell_object.possible_values[0]
        end
      end

    end

    board

  end

  def solved?
    @cell_array.each { |cell| return false if cell.value == 0 }
    true
  end

  def board
    @cell_array.each_slice(9) { |row| p row }
  end


end


test = Sudoku.new("619030040270061008000047621486302079000014580031009060005720806320106057160400030")
test.solve!