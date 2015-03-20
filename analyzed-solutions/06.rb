class Sudoku
  attr_reader :grid

  def initialize(board_string)
    @grid = Array.new(9) {Array.new(9)}
    input_grid = board_string.split('').each_slice(9).to_a
    input_grid.each_with_index do |row, r|
      row.each_with_index do |value, c|
        square = Square.new(r, c)
        square.set_value(value.to_i) unless value == '-'
        @grid[r][c] = square
      end
    end
  end

  def solve
    update_possible_values

    100.times do |i|
      update_value_if_only_one_possible_value
      deduce_values
    end
  end

  # Sets the value at a square
  def set_value(square, value)
    square.set_value(value)
    update_possible_values(square)
  end

  # Given a square, removes the square's value from the list of possible values
  # for each other square in the row, column, and block
  def update_possible_values(square=nil)
    # Only run for one square if a square parameter is given
    if square
      if square.value
        remove_possible_values_in_row(square.row, square.column, square.value)
        remove_possible_values_in_column(square.row, square.column, square.value)
        remove_possible_values_in_block(square.row, square.column, square.block, square.value)
      end

    # Else check all squares and remove
    else
      @grid.flatten(1).each do |square|
        if square.value
          remove_possible_values_in_row_of(square)
          remove_possible_values_in_column(square.row, square.column, square.value)
          remove_possible_values_in_block(square.row, square.column, square.block, square.value)
        end
      end
    end
  end

  # Removes a value from all possible values in that row
  def remove_possible_values_in_row_of(square)
    value_to_remove = square.value
    other_squares_from_row = get_row(square.row).reject { |next_square| next_square.column == square.column }
    other_squares_from_row.each do |square|
      square.possible_values.delete(value_to_remove)
    end
  end

  # Removes a value from all possible values in that column
  def remove_possible_values_in_column(row_id, column_id, value_to_remove)
    get_column(column_id).reject { |square| square.row == row_id }.each do |square|
      square.possible_values.delete(value_to_remove)
    end
  end

  # Removes a value from all possible values in that block
  def remove_possible_values_in_block(row_id, column_id, block_id, value_to_remove)
    get_block(block_id).reject { |square| row_id == square.row && column_id == square.column }.each do |square|
      square.possible_values.delete(value_to_remove)
    end
  end

  # Updates square.value if square.possible_values only includes one digit
  def update_value_if_only_one_possible_value
    @grid.flatten(1).each do |square|
      if square.possible_values.length == 1 && square.value == nil
        set_value(square, square.possible_values[0])
      elsif square.possible_values.length == 0
        raise "MAYDAY. No possible values for #{square}: row=#{square.row}, column=#{square.column}"
      end
    end
  end

  def deduce_values
    @grid.flatten(1).each do |square|
      unless square.value
        deduce_values_if_only_possible_value_in_row(square)
      end
      unless square.value
        deduce_values_if_only_possible_value_in_column(square)
      end
      unless square.value
        deduce_values_if_only_possible_value_in_block(square)
      end
    end
  end

  def deduce_values_if_only_possible_value_in_row(square)
    other_squares = get_row(square.row).reject{ |other_square| other_square.column == square.column }.select{|other_square| other_square.value == nil}
    other_squares_possible_values = other_squares.map { |other_square| other_square.possible_values }.flatten
    square.possible_values.each do |possible_value|
      unless other_squares_possible_values.include?(possible_value)
        set_value(square, possible_value)
      end
    end
  end

  def deduce_values_if_only_possible_value_in_column(square)
    other_squares = get_column(square.column).reject{ |other_square| other_square.row == square.row }.select{|other_square| other_square.value == nil}
    other_squares_possible_values = other_squares.map { |other_square| other_square.possible_values }.flatten
    square.possible_values.each do |possible_value|
      unless other_squares_possible_values.include?(possible_value)
        set_value(square, possible_value)
      end
    end
  end

  def deduce_values_if_only_possible_value_in_block(square)
    other_squares = get_block(square.block).reject{ |other_square| other_square.row == square.row && other_square.column == square.column }.select{|other_square| other_square.value == nil}
    other_squares_possible_values = other_squares.map { |other_square| other_square.possible_values }.flatten
    square.possible_values.each do |possible_value|
      unless other_squares_possible_values.include?(possible_value)
        set_value(square, possible_value)
      end
    end
  end

  def get_row(row_id)
    @grid[row_id]
  end

  def get_column(column_id)
    squares = []
    @grid.each do |row|
      squares << row[column_id]
    end
    squares
  end

  def get_block(block_id)
    @grid.flatten(1).select {|square| block_id == square.block}
  end

  # Returns a string representing the current state of the board
  def to_s
    s = ""
    @grid.each do |row|
      row.each do |square|
        if square.value
          s += square.value.to_s
        else
          s += '-'
        end
      end
    end
    s
  end

  def print_grid
    s = to_s.split('')
    while s.length > 0
      puts s.shift(9).join(' ')
    end
    puts
  end
end

class Square
  attr_reader :row, :column, :block
  attr_accessor :value, :possible_values

  def initialize(row, column, value=nil, possible_values=(1..9).to_a)
    @row = row
    @column = column
    @block = 3 * (row / 3) + (column / 3)
    @value = value
    @possible_values = possible_values
  end

  def set_value(value)
    @value = value
    @possible_values = [value]
  end
end


sudoku = Sudoku.new('53--7----6--195----98----6-8---6---34--8-3--17---2---6-6----28----419--5----8--79')
sudoku.solve
sudoku.print_grid

# sudoku = Sudoku.new('---6891--8------2915------84-3----5-2----5----9-24-8-1-847--91-5------6--6-41----')
# sudoku.solve
# sudoku.to_s

# sudoku = Sudoku.new('-3-5--8-45-42---1---8--9---79-8-61-3-----54---5------78-----7-2---7-46--61-3--5--')
# sudoku.solve
# sudoku.to_s

# sudoku = Sudoku.new('-96-4---11---6---45-481-39---795--43-3--8----4-5-23-18-1-63--59-59-7-83---359---7')
# sudoku.solve
# sudoku.to_s

# sudoku = Sudoku.new('----754----------8-8-19----3----1-6--------34----6817-2-4---6-39------2-53-2-----')
# sudoku.solve
# sudoku.to_s

# sudoku = Sudoku.new('3---------5-7-3--8----28-7-7------43-----------39-41-54--3--8--1---4----968---2--')
# sudoku.solve
# sudoku.to_s

# 3-26-9--55--73----------9-----94----------1-9----57-6---85----6--------3-19-82-4-
# -2-5----48-5--------48-9-2------5-73-9-----6-25-9------3-6-18--------4-71----4-9-
# --7--8------2---6-65--79----7----3-5-83---67-2-1----8----71--38-2---5------4--2--
# ----------2-65-------18--4--9----6-4-3---57-------------------73------9----------
# ---------------------------------------------------------------------------------