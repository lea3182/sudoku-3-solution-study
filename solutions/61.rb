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
require "pry"
class Sudoku
  attr_accessor :board

  def initialize(board_string)
    self.board = []
    board_array = board_string.split("")
    board_array.each_slice(9){ |slice| self.board << slice }
    board
    self.find_empty_cell
  end

  def solve(coord)
    if self.possible_answers(coord).length == 1
      self.board[coord[0]][coord[1]] = self.possible_answers(coord)[0]
      find_empty_cell
    end
  end

  def find_empty_cell
    board.each_with_index do | row, row_num |
       row.each_with_index do | val, col_num |
        if val == "-"
          solve([row_num, col_num])
          self.to_s
          sleep 0.2
          puts "\e[H\e[2J"
        end
      end
      []
      end
    end

  def collect_horizontal(row_num)
    board[row_num].select{|elem| elem != "-"}
  end

  def collect_vertical(col_num)
    board.transpose[col_num].select { |elem| elem != "-"}
  end

  # #INPUT: coordinate (2 element array)
  # #OUTPUT: the coordinate of the center
  # #LOGIC: given any coordinate, method will return the center cell of the box containing the coordinate.
  # def find_center(coord)
  #   out = []
  #   if (0..2) === coord.first
  #   end


  # end

  #INPUT: the coordinate of the center of the containing boc
  #OUTPUT: an array of numbers that are contained in the box
  #LOGIC: will push into an array the values of each of the center's surrounding locations.

  def collect_box(coord)
    collect_boxes #MOVE THIS
    @boxes[which_box(coord)]
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

  def collect_boxes
    thirds_flipped = board.each_slice(3).to_a.map { |third| third.transpose }
    ninths = thirds_flipped.map { |third| third.each_slice(3).to_a}
    @boxes = flatten(ninths).map do |box|
        box.reject{ |elem| elem == '-' }
      end
  end

  def flatten(ar)
    ar.map do |third|
      third.map { |block| block.flatten.uniq }
    end.flatten(1)
  end

  def possible_answers(coord)
    eliminated = (collect_horizontal(coord.first) + collect_vertical(coord.last) + collect_box(coord)).uniq
    [*'1'..'9'] - eliminated
  end


  def to_s
    puts
    puts
    p "  __ __   _______ __   __ ______  _______ ___   _ __   __ __ __  "
    p " |  |  | |       |  | |  |      ||       |   | | |  | |  |  |  | "
    p " |  |  | |  _____|  | |  |  _    |   _   |   |_| |  | |  |  |  | "
    p " |  |  | | |_____|  |_|  | | |   |  | |  |      _|  |_|  |  |  | "
    p " |__|__| |_____  |       | |_|   |  |_|  |     |_|       |__|__| "
    p "  __ __   _____| |       |       |       |    _  |       |__ __  "
    p " |__|__| |_______|_______|______||_______|___||_|________|__|__| "
    puts
    puts
    board.each{|row| p row.join(" | ")}
  end
end

game = Sudoku.new("---26-7-168--7--9-19---45--82-1---4---46-29---5---3-28--93---74-4--5--367-3-18---")
# binding.pry
