require 'debugger'

class Sudoku
  attr_reader :box_indices
  def initialize(board_string)
    @board = board_string
    @box_indices = {}
    [*0..80].each do |index|
      if @box_indices.has_key?(what_box(index))
        @box_indices[what_box(index)].push(index)
      else
        @box_indices[what_box(index)] = [index]
      end
    end
  end

  def what_box(index)
    output = ""
    output << ((index / 9) / 3).to_s << ((index % 9) / 3).to_s
  end

  def get_row(index)
    row_index = (index / 9)
    [*0..80].reject! {|i| i/9 != row_index }
  end


  def get_col(index)
    col_index = index % 9
    [*0..80].reject! {|i| i%9 != col_index }
  end


  def get_box(index)
    @box_indices[what_box(index)]
  end

  def solve_cell(index)
    cell_indices = get_box(index) | get_col(index) | get_row(index)
    used_values = cell_indices.map { |i| @board[i] }
    used_values.uniq!
    used_values.delete('0')
    possible_values = [*1..9].map {|x| x.to_s} - used_values
    @board[index] = possible_values[0] if possible_values.length == 1
  end

  def solve!
    while @board.include?('0')
      [*0..80].each do |i|
        solve_cell(i) if @board[i] == '0'
      end
    end
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    output = ""
    [*0..80].each do |i|
      output << @board[i].ljust(4)
      output << "\n" if (i+1) % 9 == 0
    end
    output
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# board_string = File.readlines('sample.unsolved.txt').last.chomp

# game = Sudoku.new(board_string)

game = Sudoku.new('619030040270061008000047621486302079000014580031009060005720806320106057160400030')


puts game.board

# Remember: this will just fill out what it can and not "guess"
puts game.board

puts "Solving Sudoku..."
game.solve!
puts game.board
# p game.inspect

# p game.get_row(20)
# p game.get_col(20)
# p game.get_box(20)
# p game.box_indices

