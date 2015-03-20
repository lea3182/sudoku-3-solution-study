require 'set'

class Cell
  attr_accessor :num, :potential_nums

  def initialize(num)
    @num = num
    @potential_nums = Set.new(num == 0 ? 1..9 : nil)
  end

  def to_s
    num.to_s
  end
end

class Sudoku
  attr_accessor :board

  def initialize(board_string)
    #@board = Array.new(9) { Array.new(9) }
    @board = board_string.split("").each_slice(9).map do |row|
      row.map do |num|
        Cell.new(num)
      end
    end
  end

  def to_s
    s = ""
    @board.each_with_index do |row, index|
      if index % 3 == 0
        s << "-"*12 << "\n"
      end
      row.each_slice(3) do |minirow|
        minirow.each do |cell|
          s << cell.to_s
        end
        s << "|"
      end
      s << "\n"
    end
    s << "-"*12 << "\n"
  end

  def solve!
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board

  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
#game.solve!

puts game