# "Sudocode"
# I: string of board
# O: print board

#1. Iterate through all cells
  # Replace all 0 with array of possible numbers
  #1A. Find all numbers in row, column, and box based on current cell
  #1B. delete already given numbers from list of possible numbers
    # If only one number remains in possible num, set value of that cell

class Sudoku
  def initialize(board_string)
    @s_board = SudokuBoard.new(board_string)
  end

  def solve!
    prior_board = @s_board.board.dup
    while true
      @s_board.board.each_with_index do |cell, cell_index|
        if cell == "0"
          logical_fill_in(cell_index)
        end
      end
      break if prior_board == @s_board.board
      prior_board = @s_board.board.dup
    end
    # p @s_board.check_solved
  end

  def logical_fill_in(cell_index)
    existing_nums = []
    existing_nums += @s_board.get_row(@s_board.find_row_index(cell_index))
    existing_nums += @s_board.get_col(@s_board.find_col_index(cell_index))
    existing_nums += @s_board.get_box(@s_board.find_box_index(cell_index))
    existing_nums.uniq!.sort!
    zero_to_nine = %w(0 1 2 3 4 5 6 7 8 9)
    zero_to_nine.reject! do |num|
      existing_nums.include?(num)
    end
    if zero_to_nine.length == 1
      @s_board.set_board_value(cell_index, zero_to_nine[0])
    end
    zero_to_nine
  end

  def board
    temp_str = ""
    @s_board.board.each_with_index do |num, num_ind|
      temp_str += "\n" if num_ind % 9 == 0 && num_ind != 0
      temp_str += " " + "-"*31 + "\n" if num_ind % 27 == 0
      temp_str += (num_ind % 3 == 0 ? " | " : "  ") + num + (num_ind % 9 == 8 ? " | " : "")
    end
    temp_str += "\n " + "-"*31
    temp_str
  end
end


class SudokuBoard
  attr_reader :solved, :board

  def initialize(board_string)
    @board = board_string.split("")
    @solved = false
  end

  def set_board_value(index, value)
    @board[index] = value
  end

  def get_row(row_num)
    temp_arr = []
    9.times do |count|
      temp_arr << @board[row_num*9 + count]
    end
    temp_arr
  end

  def get_col(col_num)
    temp_arr = []
    9.times do |count|
      temp_arr << @board[count*9 + col_num]
    end
    temp_arr
  end

  def get_box(box_num)
    temp_arr = []
    temp_arr += get_row((box_num/3)*3+0)[((box_num%3)*3)..(((box_num%3)*3)+2)]
    temp_arr += get_row((box_num/3)*3+1)[((box_num%3)*3)..(((box_num%3)*3)+2)]
    temp_arr += get_row((box_num/3)*3+2)[((box_num%3)*3)..(((box_num%3)*3)+2)]
    temp_arr
  end

  def find_row_index(index_num)
    index_num / 9
  end

  def find_col_index(index_num)
    index_num % 9
  end

  def find_box_index(index_num)
    (find_col_index(index_num) / 3) + ((find_row_index(index_num) / 3)*3)
  end

  def check_solved
    9.times do |count|
      return false unless get_row(count).sort == [*"1".."9"]
      return false unless get_col(count).sort == [*"1".."9"]
      return false unless get_box(count).sort == [*"1".."9"]
    end
    true
  end
end

board_string = File.readlines('set-02_project-euler_50-easy-puzzles.txt').each do |board_str|
  game = Sudoku.new(board_str.chomp)
  game.solve!
  puts game.board
end