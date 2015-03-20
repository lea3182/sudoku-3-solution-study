require 'pry'

class Sudoku
  attr_accessor :board

  def initialize(board_string)
    board_split = board_string.split("").map! {|x| x.to_i}
    @board = Array.new(9) {board_split.shift(9)}
    @sudoku_numbers = (1..9).to_a
  end

  def solve
    until solved?
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index|
          if cell == 0
            possibilities = find_possibilities(row_index,col_index)
            if possibilities.length == 1
              @board[row_index][col_index] = possibilities.pop
            end
          end
        end
      end
    end
  end

  def return_box(row, col)
    boxes = [
      [[0,0], [0,1], [0,2], [1,0], [1,1], [1,2], [2,0], [2,1], [2,2]],
      [[0,3], [0,4], [0,5], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5]],
      [[0,6], [0,7], [0,8], [1,6], [1,7], [1,8], [2,6], [2,7], [2,8]],
      [[3,0], [3,1], [3,2], [4,0], [4,1], [4,2], [5,0], [5,1], [5,2]],
      [[3,3], [3,4], [3,5], [4,3], [4,4], [4,5], [5,3], [5,4], [5,5]],
      [[3,6], [3,7], [3,8], [4,6], [4,7], [4,8], [5,6], [5,7], [5,8]],
      [[6,0], [6,1], [6,2], [7,0], [7,1], [7,2], [8,0], [8,1], [8,2]],
      [[6,3], [6,4], [6,5], [7,3], [7,4], [7,5], [8,3], [8,4], [8,5]],
      [[6,6], [6,7], [6,8], [7,6], [7,7], [7,8], [8,6], [8,7], [8,8]]
    ]

    boxes.each_with_index do |box, index|
      return box if box.include? [row, col]
    end

  end

  def find_box(row, col)
    box = return_box(row,col)
    box_elements = box.map { |row, col| @board[row][col] }
    box_elements - [0]
  end

  def find_row(row)
    @board[row] - [0]
  end

  def find_col(col)
    col_elements = [*0..8].map { |row| @board[row][col] }
    col_elements - [0]
  end

  def find_possibilities(row, col)
    [*1..9] - (find_box(row, col) + find_row(row) + find_col(col))
  end

  def solved?
    !@board.flatten.include? 0
  end

  def board
    # SHOW the updated board with the new values
  end

  # Returns a nicely formatted string representing the current state of the board
  def to_s
    display_board = ""
    @board.each do |cell|
      cell.each do |number|
        display_board << "#{number}".ljust(3)
      end
      display_board << "\n"
    end
    print display_board
  end

end

# '4-526978168257149319783456282-195347374682915951743628519326874248957136763418259'

@board = '---26-7-168--7--9-19---45--82-1---4---46-29---5---3-28--93---74-4--5--367-3-18---'
# # print board
@test = Sudoku.new(@board)
@test.to_s
puts ""
@test.solve
# # # print test.board
puts ""
@test.to_s