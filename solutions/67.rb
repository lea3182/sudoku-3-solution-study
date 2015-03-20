# **PSEUDOCODE**
# start SUDOKU class
#   initialize

#   SOMEWHERE
#   - coordinate system

#   begin GET_ROW method
#     slice by 9
#   end GET_ROW method

#   begin GET_COLUMN method
#     grab each group of i + 9
#   end GET_COLUMN method

#   begin GET_BOX method
#   end GET_BOX method

#   begin SOLVE method

#   end SOLVE method

#   begin BOARD method
#   end BOARD method

# end SUDOKU class

# **************************************


# start BOARD class
#   initialize
#     @board = []
#     @row_value = 1
#     @row_conditional = 0
#     @column_value = 1
#     @column_conditional = 0
#     @cell_value = 1
#     @cell_conditional = 0
#     @face_value = ''
#     board_string.each_char { board << Cell.new { get_Cell_values } }
#   end

#   get_space_values
#     row_value += 1 if (row_conditional + 1) % 9
#     row_conditional += 1

#     row divmod(quotient,remainder)


#     (column_conditional + 1) % 9 ? column_value = 0 : column_value += 1
#     column_conditional += 1

#     case cell_conditional
#     when % 27 == 0
#       cell_value += 1
#     when % 9 ==0
#       cell_value -= 2
#     when % 3 == 0
#       cell_value += 1

#       return row,column,cell,face_value

#     divmod(row)

# start SPACE class
#   initialize(row,column,cell,face_value)
#     @row = row
#     @column = column
#     @cell = cell
#     @face_value = face_value

# end SUDOKU class



# =end
=begin

until no object's face_value == 0
each object whose face_value == 0
  valid = []
  iterate through an array of 1-9
  if a face_value works in that spot, shovel into valid
  if valid.length == 1, you can use that face_value
  if valid.length == 0 || valid.length > 1 then we can't plug anything in

See if face_value of current object matches:
face_values of objects in column
face_values of objects in row
face_values of objects in cell



=end

class Board
  attr_accessor :board, :board_string, :counter
  def initialize(board_string)
    @board_string = board_string
    @board = []
    @counter = 0
    get_cell_values
  end

  #Private?
  def get_cell_values
    board_string.each_char do |character|
      row, column = counter.divmod(9)
      face_value = character
      box = (3*(counter/27))+(column/3)
      board << Cell.new(row,column,face_value,box)
      @counter += 1
    end
  end

  def solve!
      @board.each do |cell|
        guess_value(cell) if cell.face_value == "0"
      end

      board_as_string = board.map {|cell| cell.face_value}.join('')
      return "Solved" unless board_as_string.include?("0")
      solve!
  end

  def guess_value(current_cell)
    array = []
    @board.select { |cell| array << cell.face_value if cell.row == current_cell.row}
    @board.select { |cell| array << cell.face_value if cell.column == current_cell.column}
    @board.select { |cell| array << cell.face_value if cell.box == current_cell.box}
    valids = ["1","2","3","4","5","6","7","8","9"] - array.uniq
    current_cell.face_value = valids.first if valids.size == 1
  end

  def print_board
    collected_string = board.map {|cell| cell.face_value}.join('')
    puts "It looks like this:"
    puts "---------------------"
    9.times { puts collected_string.slice!(0..8) }
  end
end

#@board.select cell.face_value where cell.row == ? => gives you all the values already in a row

#(1..9).to_a - (row_array + col_array + box_array).uniq


class Cell
  attr_accessor :face_value, :box, :row, :column
  def initialize(row, column, face_value, box)
    @row = row
    @column = column
    @face_value = face_value
    @box = box
  end

  def row
    @row
  end

  def column
    @column
  end

  def box
    @box
  end

end


test = Board.new('105802000090076405200400819019007306762083090000061050007600030430020501600308900')

string1 = ''
string2 = ''

test.board.each {|cell| string1 << cell.face_value}

p test.solve!

test.board.each {|cell| string2 << cell.face_value}


puts "Original string: #{string1}"

puts "Solved string:   #{string2}"
#619238745274561398853947621486352179792614583531879264945723816328196457167485932

test.print_board