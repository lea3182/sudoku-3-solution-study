class Sudoku

  attr_accessor :row, :board, :test_array, :box_possibilities

  def initialize(board_string)
    @board = board_string.split("").each_slice(9).to_a
    @test_array = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @box_possibilities = []
  end

  def get_row(row_index)
    @board[row_index]
  end

  def get_column(column_index)
    @board.transpose[column_index]
  end

  def get_square(row_index, column_index)
    square = []
    if row_index/3 >= 2
      for r in 6..8
        if column_index/3 >= 2
          for c in 6..8
            square << board[r][c]
          end
        elsif column_index/3 >= 1
          for c in 3..5
            square << board[r][c]
          end
        else
          for c in 0..2
            square << board[r][c]
          end
        end
      end
    elsif row_index/3 >= 1
      for r in 3..5
        if column_index/3 >= 2
          for c in 6..8
            square << board[r][c]
          end
        elsif column_index/3 >= 1
          for c in 3..5
            square << board[r][c]
          end
        else
          for c in 0..2
            square << board[r][c]
          end
        end
      end
    else
      for r in 0..2
        if column_index/3 >= 2
          for c in 6..8
            square << board[r][c]
          end
        elsif column_index/3 >= 1
          for c in 3..5
            square << board[r][c]
          end
        else
          for c in 0..2
            square << board[r][c]
          end
        end
      end
    end
    square
  end

  def gather_unique_non_possibilities(row_index, column_index)
    unique_non_possibilities = [get_row(row_index),get_column(column_index),get_square(row_index,column_index)]
    unique_non_possibilities.flatten!.uniq
  end

  def check_box(row_index, column_index)
    cell_possibilities = []
    if board[row_index][column_index] != "0"
      return cell_possibilities << board[row_index][column_index]
    else
      test_array.each do |num|
        if gather_unique_non_possibilities(row_index,column_index).include?(num) != true
          cell_possibilities << num
        end
      end
    end
    cell_possibilities
  end

  def assign_box(row_index, column_index)
    cell_possibilities = []
    cell_possibilities = check_box(row_index, column_index)
    if cell_possibilities.length == 1
      box = cell_possibilities.join("")
      board[row_index][column_index] = box
    elsif cell_possibilities.length > 1
      box = "0"
    end
  end

  def solve!
    until board.flatten.include?('0') == false
      board.each_with_index do |row, row_index|
        row.each_index do |column_index|
          board[row_index][column_index] = assign_box(row_index, column_index)
        end
      end
    end
    board_state
  end

  def board_state
      puts "---------------------"
  puts "#{board[0][0]} #{board[0][1]} #{board[0][2]} | #{board[0][3]} #{board[0][4]} #{board[0][5]} | #{board[0][6]} #{board[0][7]} #{board[0][8]}"
  puts "#{board[1][0]} #{board[1][1]} #{board[1][2]} | #{board[1][3]} #{board[1][4]} #{board[1][5]} | #{board[1][6]} #{board[1][7]} #{board[1][8]}"
  puts "#{board[2][0]} #{board[2][1]} #{board[2][2]} | #{board[2][3]} #{board[2][4]} #{board[2][5]} | #{board[2][6]} #{board[2][7]} #{board[2][8]}"
  puts "---------------------"
  puts "#{board[3][0]} #{board[3][1]} #{board[3][2]} | #{board[3][3]} #{board[3][4]} #{board[3][5]} | #{board[3][6]} #{board[3][7]} #{board[3][8]}"
  puts "#{board[4][0]} #{board[4][1]} #{board[4][2]} | #{board[4][3]} #{board[4][4]} #{board[4][5]} | #{board[4][6]} #{board[4][7]} #{board[4][8]}"
  puts "#{board[5][0]} #{board[5][1]} #{board[5][2]} | #{board[5][3]} #{board[5][4]} #{board[5][5]} | #{board[5][6]} #{board[5][7]} #{board[5][8]}"
  puts "---------------------"
  puts "#{board[6][0]} #{board[6][1]} #{board[6][2]} | #{board[6][3]} #{board[6][4]} #{board[6][5]} | #{board[6][6]} #{board[6][7]} #{board[6][8]}"
  puts "#{board[7][0]} #{board[7][1]} #{board[7][2]} | #{board[7][3]} #{board[7][4]} #{board[7][5]} | #{board[7][6]} #{board[7][7]} #{board[7][8]}"
  puts "#{board[8][0]} #{board[8][1]} #{board[8][2]} | #{board[8][3]} #{board[8][4]} #{board[8][5]} | #{board[8][6]} #{board[8][7]} #{board[8][8]}"
  puts "---------------------"
  end
#HELLO
end
