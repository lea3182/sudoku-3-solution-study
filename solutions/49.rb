# CREATE class Cell
#   cell.value = 0
#   cell.position
#   cell.possible values
#   cell.has_number

# CREATE class Board
#   Board.rows
#   Board.columns
#   Board.grids
#   Board.total_nums

# CREATE class Sodoku(string)
#   blanks = string.to_a
#   blanks.each do |blank|
#     instantiate cell for blank
#     values << cell
#   end
#   get Board.rows from values
#   get Board.columns from values
#   get Board.grids from values
#   until Board.total_nums == string.length
#     parse through values and for each:
#     check if value has number
#       move on to the next value
#     check if possible values can be removed
#     if possible values == 1
#       put possible value into value
#       cell.has_number = true
#       Board.total_nums += 1
#   end
class Cell
  attr_accessor :value, :position, :row, :col, :grid, :possible_values, :has_number
  def initialize(value = 0, position)
    @value = value
    @position = position
    @has_number = @value.to_i > 0
    @possible_values = (1..9).to_a
    @row = @position/9
    @col = @position%9
    @grid = (((@position % 3)/3)*3)+((@position/3)/3)
  end

  def update_values(num)
    @possible_values.delete(num)
    if @possible_values.length == 1
      @value = @possible_values[0].to_s
      @has_number = true
    end
  end
end

class Sudoku
  def initialize(board_string)
    @board = []
    board_string.split('').each_with_index do |value, position|
      @board << Cell.new(value, position)
    end
  end

  def solve!
    until solved?
      @board.each do |cell|
        if cell.has_number == false
          @board.each do |second_cell|
            if second_cell.row == cell.row || second_cell.col == cell.col || second_cell.grid == cell.grid
              cell.update_values(second_cell.value.to_i)
            end
          end
        end
      end
    end
  end

  def solved?
    count = 0
    @board.each do |cell|
      if cell.has_number
        count += 1
      end
    end
    return count == @board.length
  end
  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    string = ""
    @board.each do |cell|
      string << cell.value
    end
    array = string.split('')
    puts "----------------------"
    3.times {3.times {3.times {print array.shift+ " "}
              print "| "}
              print "\n"}
    puts "----------------------"
    3.times {3.times {3.times {print array.shift+ " "}
              print "| "}
              print "\n"}
    puts "----------------------"
    3.times {3.times {3.times {print array.shift+ " "}
              print "| "}
              print "\n"}
    puts "----------------------"
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

game.board