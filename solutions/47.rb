require 'colored'
require 'debugger'

class Sudoku
  attr_accessor :box

  def initialize(board_string)
    @board = board_string
    @box = {  '00' => [],
              '01' => [],
              '02' => [],
              '10' => [],
              '11' => [],
              '12' => [],
              '20' => [],
              '21' => [],
              '22' => [] }
    populate_box
  end

  def solve!
    while @board.include? "0"
      @board.each_char.with_index do |char,index|
        if char == '0'
          not_poss = ((1..9).to_a - (row(index) | col(index) | box(index)))
          @board[index] = not_poss[0].to_s if not_poss.length == 1
        end
      end
    end
  end

  def box(index)
    @box[((index / 9) / 3).to_s + ((index % 9) / 3).to_s]
  end

  def populate_box
    @board.each_char.with_index do |num, index|
      unless num == '0'
        @box[((index / 9) / 3).to_s + ((index % 9) / 3).to_s] << num.to_i
      end
    end
    @box
  end

  def row(index)
    until index % 9 == 0
      index -= 1
    end
    row_array = [index]
    8.times { row_array << index += 1 }
    row_array.each.with_index do |char,index|
      row_array[index] = @board[char.to_i].to_i
    end
    row_array.reject{ |i| i == 0}
  end

  def col(index)
    seq = (0..8).to_a
    until seq.include?(index)
      index -= 9
    end
    col_array = [index]
    8.times { col_array << index += 9 }
    col_array.each.with_index do |char,index|
      col_array[index] = @board[char.to_i].to_i
    end
    col_array.reject{ |i| i == 0 }
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    puts '---------------------'.green
    output_string = ""
    @board.each_char.with_index do |char,index|
      output_string << char + ' '
      if index % 9 == 2 || index % 9 == 5
        output_string << '| '.green
      elsif index % 9 == 8
        output_string << "\n"
        if (index + 1) % 27 == 0
          output_string << '---------------------'.green + "\n"
        end
      end
    end
    output_string
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
puts game.board
game.solve
puts game.board
