class Sudoku
  def initialize(board_string)
    value = board_string.split("").map(&:to_i)
    @board = Array.new(9) { Array.new(9) { Cell.new(value.shift)}}
  end

  def solve!
    until finished
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          if cell.solved == false
            all_cells = check_column(column_index) + check_row(row_index) + check_box(row_index, column_index)
            unique_cells = all_cells.uniq.map { |i| i.value }
            potential_nums = (1..9).to_a - unique_cells
            if potential_nums.length == 1
              cell.value = potential_nums[0]
              cell.solved
            end
          end
        end
      end
    end
  end

  def finished
    output = output_string
    if output.split("").include?("0")
      return false
    else
      true
    end
  end

  def check_column(column_index)
    column_nums = []
    i = 0
    while i < 9
      column_nums << @board[i][column_index]
      i += 1
    end
    return column_nums
  end

  def check_row(row_index)
    row_nums = []
    i = 0
    while i < 9
      row_nums << @board[row_index][i]
      i += 1
    end
    return row_nums
  end

  def check_box(row_index, column_index)
    box = []
    a = [0,1,2]
    b = [3,4,5]
    c = [6,7,8]
    i = 0
    if a.include?(column_index)
      while i < 3
        box << check_row(row_index)[a[0]]
        box << check_row(row_index)[a[1]]
        box << check_row(row_index)[a[2]]
        i += 1
      end
    elsif b.include?(column_index)
      while i < 3
        box << check_row(row_index)[b[0]]
        box << check_row(row_index)[b[1]]
        box << check_row(row_index)[b[2]]
        i += 1
      end
    elsif c.include?(column_index)
      while i < 3
        box << check_row(row_index)[c[0]]
        box << check_row(row_index)[c[1]]
        box << check_row(row_index)[c[2]]
        i += 1
      end
    end
    box
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def output_string
    output = ""
    @board.each do |row|
      row.each do |cell|
        output << cell.value.to_s
      end
    end
    output
  end

  def board
    output = output_string.split("")
    output[3]
     "     ---------------------
     #{output[0]} #{output[1]} #{output[2]} | #{output[3]} #{output[4]} #{output[5]} | #{output[6]} #{output[7]} #{output[8]}
     #{output[9]} #{output[10]} #{output[11]} | #{output[12]} #{output[13]} #{output[14]} | #{output[15]} #{output[16]} #{output[17]}
     #{output[18]} #{output[19]} #{output[20]} | #{output[21]} #{output[22]} #{output[23]} | #{output[24]} #{output[25]} #{output[26]}
     ---------------------
     #{output[27]} #{output[28]} #{output[29]} | #{output[30]} #{output[31]} #{output[32]} | #{output[33]} #{output[34]} #{output[35]}
     #{output[36]} #{output[37]} #{output[38]} | #{output[39]} #{output[40]} #{output[41]} | #{output[42]} #{output[43]} #{output[44]}
     #{output[45]} #{output[46]} #{output[47]} | #{output[48]} #{output[49]} #{output[50]} | #{output[51]} #{output[52]} #{output[53]}
     ---------------------
     #{output[54]} #{output[55]} #{output[56]} | #{output[57]} #{output[58]} #{output[59]} | #{output[60]} #{output[61]} #{output[62]}
     #{output[63]} #{output[64]} #{output[65]} | #{output[66]} #{output[67]} #{output[68]} | #{output[69]} #{output[70]} #{output[71]}
     #{output[72]} #{output[73]} #{output[74]} | #{output[75]} #{output[76]} #{output[77]} | #{output[78]} #{output[79]} #{output[80]}
     ---------------------"
  end
end



class Cell
  attr_accessor :value

  def initialize(value)
    @value = value
    @solved = false
  end

  def solved
    if @value == 0
      @solved
    else
      return @solved = true
    end
  end


end


# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

puts game.board
