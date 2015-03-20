class Sudoku

  def initialize(board_string)
    @board = board_string.split("")
  end


  def solve!
    return @board if solved?
    @board.each_with_index do |cell, cell_index|
      next unless cell == '0'
      replace_cell_if_only_answer_at cell_index
    end
    solve!
  end


  def solved?
    !@board.include?('0')
  end


  def replace_cell_if_only_answer_at index
    candidates = possible_answers_at index
    @board[index] = candidates.first if candidates.length == 1
  end


  def possible_answers_at index
    [*"1".."9"] - ( row(index) | col(index) | box(index) )
  end

# These methods return a single array from
# their collections for a given spot on the board

  def row index
    rows[index / 9]
  end

  def col index
    columns[index % 9]
  end

  def box index
    boxes[ find_box_index_for(index) ]
  end

# These methods return 2D arrays of our @board's
# rows, columns and boxes

  def rows
    @board.each_slice(9).to_a
  end

  def columns
    @board.each_slice(9).to_a.transpose
  end

  def boxes
    boxes = Array.new(9) { Array.new }
    @board.each_with_index do |cell, cell_index|
      boxes[ find_box_index_for(cell_index) ].push cell
    end
    boxes
  end

  def find_box_index_for index
    (index/ 9 / 3 * 3) + (index % 9 / 3)
  end

  def to_s
    @board.each_slice(9).to_a.map { |row| row.join(' ') }.join("\n")
  end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.

board_string = File.readlines('sample.unsolved.txt').first.chomp
puzzle = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"

puzzle.solve!

puts puzzle