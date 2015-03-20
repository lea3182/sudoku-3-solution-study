# Dionne Stanfield and Jay Davis

#==================PSEUDOCODE===========================
=begin
INPUT: string object
OUTPUT: Sudoko object (solved board)

LOGIC:
Create a board.

Scan the board looking for an a dash (empty cell):
  If dash: determine potential answers to fill dash
  If not dash: Continue scanning the board

Determine potential answers
  Find all filled in numbers
    Note all the numbers already present in the containing row
    Note all the numbers already present in the containing col
    Note all the numbers already present in the containing box


  Collect/take note of all numbers present in row, col and box
    Compare row,col,box numbers to the only possible answers ([1,2,3,4,5,6,7,8,9])
    If there is only one answer, fill it in
    If there is more than one answer: Continue scanning the board

Place the answer in the correct cell.
Check whether the board is filled.
  if yes, STOP
  if no: Check whether there has been progress made.

Check whether there has been progress made.
  if yes, Scan the board
  if no, stop.
=end
#=========================================================

class Sudoku
  attr_accessor :board

  def initialize(board_string)
    self.board = []
    board_array = board_string.split("")
    board_array.each_slice(9){ |slice| self.board << slice }
    collect_boxes
    board
  end

  def solve
    loop { break if !scan_board }
    if find_empty_cells.empty?
      puts "Board solved\n"
    else
      puts "Cannot solve this board\n"
    end
    puts self
  end

  # private (uncommenting this breaks the tests)

  def scan_board
    find_empty_cells.each { |coord| return true if calculate_cell([coord.first, coord.last]) }
    false
  end

  def calculate_cell(coord)
    possible = possible_answers(coord)
    if possible.count == 1
      self.board[coord.first][coord.last] = possible.first
      collect_boxes
      return true
    end
    false
  end

  def find_empty_cells
    out = []
    board.each_with_index do |row, row_num|
       row.each_with_index { |val, col_num| out << [row_num, col_num] if val == "-" }
    end
    out
  end

  def possible_answers(coord)
    eliminated = (collect_horizontal(coord.first) + collect_vertical(coord.last) + collect_box(coord)).uniq
    [*'1'..'9'] - eliminated
  end

  def collect_horizontal(row_num)
    board[row_num].select{|elem| elem != "-"}
  end

  def collect_vertical(col_num)
    board.transpose[col_num].select { |elem| elem != "-"}
  end

  def collect_box(coord)
    @boxes[which_box(coord)]
  end

  def collect_boxes
    thirds_flipped = board.each_slice(3).to_a.map { |third| third.transpose }
    ninths = thirds_flipped.map { |third| third.each_slice(3).to_a}
    @boxes = flatten(ninths).map do |box|
        box.reject { |elem| elem == '-' }
      end
  end

  def flatten(ar)
    ar.map do |third|
      third.map { |block| block.flatten.uniq }
    end.flatten(1)
  end

  def which_box(coord)

    if (0..2) === coord.first
      row_candidates = [*0..2]
    elsif (3..5) === coord.first
      row_candidates = [*3..5]
    else row_candidates = [*6..8]
    end

    if (0..2) === coord.last
      col_candidates = [0,3,6]
    elsif (3..5) === coord.last
      col_candidates = [1,4,7]
    else col_candidates = [2,5,8]
    end

    return (row_candidates & col_candidates).first
  end

  # Returns a nicely formatted string representing the current state of the board
  def to_s
    out = ""
    board.each_with_index do |row, row_num|
      row.each_with_index do |val, col_num|
        out << " #{val} "
        out << "|" if col_num == 2 || col_num == 5
      end
      out << "\n"
      out << ('-' * 29) << "\n" if row_num == 2 || row_num == 5
    end
    out
  end

end




