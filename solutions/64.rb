require 'pry'

class Sudoku

  attr_reader :numbers, :board
  attr_accessor :possibilities

  def initialize(board_string)
    split_string = board_string.split("")
    @board = Array.new(9) {split_string.shift(9)}
    @numbers = ["1","2","3","4","5","6","7","8","9"]
    @values = []
    @answer = ""
  end

  def check_board
    while board_full == false
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index|
          if cell == "-"
            check_row(row_index)
            check_column(col_index)
            search_box(row_index, col_index)
            change(row_index, col_index) if comparisson
          end
        end
      end
    end
  end

  def check_box(row_index, col_index)
    if row_index <= 2
      if col_index <= 2
        1
      elsif col_index <=5
        2
      else
        3
      end
    elsif row_index <= 5
      if col_index <= 2
        4
      elsif col_index <= 5
        5
      else col_index <= 8
        6
      end
    elsif row_index <= 8
      if col_index <= 2
        7
      elsif col_index <= 5
        8
      else col_index <=8
        9
      end
    end
  end

  def search_box(row_index, col_index)
    case check_box(row_index, col_index)
      when 1
        (@board[0][0..2].concat @board[1][0..2].concat @board[2][0..2]).each do |x|
          @values << x if x != "-"
        end
      when 2
        (@board[0][3..5].concat @board[1][3..5].concat @board[2][3..5]).each do |x|
          @values << x if x != "-"
        end
      when 3
        (@board[0][6..8].concat @board[1][6..8].concat @board[2][6..8]).each do |x|
          @values << x if x != "-"
        end
      when 4
        (@board[3][0..2].concat @board[4][0..2].concat @board[5][0..2]).each do |x|
          @values << x if x != "-"
        end
      when 5
        (@board[3][3..5].concat @board[4][3..5].concat @board[5][3..5]).each do |x|
          @values << x if x != "-"
        end
      when 6
        (@board[3][6..8].concat @board[4][6..8].concat @board[5][6..8]).each do |x|
          @values << x if x != "-"
        end
      when 7
        (@board[6][0..2].concat @board[7][0..2].concat @board[8][0..2]).each do |x|
          @values << x if x != "-"
        end
      when 8
        (@board[6][3..5].concat @board[7][3..5].concat @board[8][3..5]).each do |x|
          @values << x if x != "-"
        end
      else 9
        (@board[6][6..8].concat @board[7][6..8].concat @board[8][6..8]).each do |x|
          @values << x if x != "-"
        end
    end
  end

  def check_row(row_index)
    @board[row_index].each_with_index do |cell, cell_index|
        if cell != "-"
          @values << @board[row_index][cell_index]
        end
    end
  end

  def check_column(col_index)
    @board.transpose[col_index].each_with_index do |cell, cell_index|
        if cell != "-"
          @values << cell
        end
    end
  end

  def comparisson
    reduced = @values.uniq
    possible = (@numbers - reduced)
    @values = []
    if possible.length == 1
      @answer = possible[0]
      return true
    else
      false
    end
  end

  def change(row_index,col_index)
    @board[row_index][col_index] = @answer
  end

  def board_full
    @board.each do |row|
      dashes_left = row.any? { |cell| cell == "-"  }
      if dashes_left == true
        return false
      else
       dashes_left
     end
    end
  end

  def to_s
    @board.map{ |row| row.join(" ") }.join("\n")
  end
end

File.readlines("sudoku_puzzles.txt")[0..4].each do |board|
  game = Sudoku.new(board.chomp)
  game.check_board
  puts game.to_s + "\n\n"
end

# p game.board
# puts "break"
# game.check_board



# input = board as string
# 1. check each cell in the string (board)
#   if there is a number in the cell, go to the next cell
#   if there is not a number in the cell, pass onto the next step

#   2. there is not a number in the cell
#   check the box that the cell is in (will have to define all of the boxes. hardcode maybe if using nested array? TBD)
#   check the row that the number is in
#   check the row that the column is in
#     store the numbers found in the rows, columns, and boxes into a new array

#     3. using the new array, make each occurance of the number unique so there are no repeats
#     get the length of the new array
#       if the length of the unique new array is not 8, go back to 1. and check FROM THE NEXT CELL.
#       else go to 4

#       4. if the length of the uniqer new array is 8
#       look at numbers 1-9 and figure out which # is missing
#       push that missing value onto the actual board.

#         5. update the board to show the changes.

#           6. unless board is full, go back to searching in 1.
#             *issue: do we have to make sure the board searches all 81 spaces and then loops back to 1? may be a infinite loop otherwise



# output = completed board
