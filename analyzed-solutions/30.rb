POSSIBLE_VALUES = ("1".."9").to_a
class Sudoku
  attr_accessor :board

  def initialize(board_string)
    board_val = board_string.split("")
    @board = Array.new(9) { Array.new(9) {Cell.new(board_val.shift)}}
  end

  def get_row(row_index)
    row_array = []
    row_array_cell = @board[row_index]
    row_array_cell.each do |cell|
      if cell.value != 0
        row_array << cell.value
      end
    end
    return row_array
  end

  def get_column(column_index)
    column_array = []
    @board.each do |row|
      if row[column_index].value != 0
        column_array << (row[column_index].value)
      end
    end
    return column_array
  end

  def get_box(row_index, column_index)
    row_range = nil
    column_range = nil
    if row_index <= 2
      row_range = 0..2
      if column_index <=2
        column_range = 0..2
      elsif column_index <= 5
        column_range = 3..5
      else
        column_range = 6..8
      end
    elsif row_index <= 5
      row_range = 3..5
      if column_index <=2
        column_range = 0..2
      elsif column_index <= 5
        column_range = 3..5
      else
        column_range = 6..8
      end
    elsif row_index <= 8
      row_range = 6..8
      if column_index <=2
        column_range = 0..2
      elsif column_index <= 5
        column_range = 3..5
      else
        column_range = 6..8
      end
    end
    flattened_array = sub_array(@board, row_range, column_range).flatten
    return_array = []
    flattened_array.each {|cell| return_array.push(cell.value)}
    return return_array
  end

  def solve!
    counter = 0
    while counter < 81
      counter = 0
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          if cell.value == "0"
            row_values_array = get_row(row_index)
            column_values_array = get_column(column_index)
            box_values_array = get_box(row_index, column_index)
            concatenate_array = row_values_array+column_values_array+box_values_array
            concatenate_array = concatenate_array.uniq
            cell.populate(concatenate_array)
          else
            counter += 1
          end
        end
      end
    end
  end

  def sub_array(array_2d, rows, columns)
    array_2d[rows].map {|row| row[columns]}
  end
  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    output = Array.new(9) { Array.new(9, nil) }
    @board.each_with_index do |row, row_i|
      row.each_with_index do |col, col_i|
        output[row_i][col_i] = @board[row_i][col_i].value
      end
    end
    p output
  end
end

class Cell
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def populate(array)
    differenced_array = POSSIBLE_VALUES - array
    if differenced_array.length == 1
      @value = differenced_array[0]
    end
  end

end
# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

# board_string = ""
# trial_array = ("1".."9").to_a
# trial_array.each {|digit| board_string+=(digit*9)}

game = Sudoku.new(board_string)

# p game.get_row(8)
p "<-------------------------------->"
# p game.get_column(0)
# p game.get_box(5,7)
# Remember: this will just fill out what it can and not "guess"
p game.solve!
# p game.get_box
game.board