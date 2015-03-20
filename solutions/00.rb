require 'debugger'
require 'pp'

class Sudoku
  attr_accessor :filled_board, :board_data
  attr_reader :board_string

  def initialize(board_string)
    @board_string = board_string.split(//)
    display_board # Display unsolved board
    @changes_this_round = true
  end

  # Evaluates simple logic and passes evaluation for display.

  def solve!
    simple_sudoku_logic
    puts "HERE'S YOUR BOARD, SOLVED. ?"
    display_board
  end

  def display_board
    disposable_board = []
    our_board = []

    @board_string.each { |x| disposable_board << x }

    9.times do
      our_board << "= = = = = = = = = = = = = = = = = = = = = "
      our_board << disposable_board.slice!(0..8)
    end
      our_board << "= = = = = = = = = = = = = = = = = = = = = "
    pp our_board
  end

  def find_row_elements(index) # index_3, returns an array
    row_value = (index / 9) + 1                       # 5, for ex
    answer = []
    @board_string.each_with_index do |each, i|
      if (i / 9 + 1) == row_value
          answer << each
      end
    end
    answer
  end

  def find_column_elements(index) #returns an array
    col_value = (index % 9) + 1
    answer = []
    @board_string.each_with_index do |each, i|
      if (i % 9 + 1) == col_value
          answer << each
      end
    end
    answer
  end

  def find_box_elements(index) #returns an array
    box_value = ((index / 27) * 3) + (index % 3)
    answer = []
    @board_string.each_with_index do |each, i|
      if i == 0
        i += 1
      end
      if ( ( (i / 27) * 3) + (i % 3)) == box_value
          answer << each
      end
    end
    answer
  end

  def simple_sudoku_logic # (argument?)
    test = find_row_elements(10) #(which string[10])
    board_string.each_with_index do |cell, index|
      row = find_row_elements(index)
      col = find_column_elements(index)
      box = find_box_elements(index)
      # cell =  (1..9) - (row + col + box) (merge or unique)) length is 1
    end

  end

  def crazy_sudoku_logic

  end


end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = "619030040270061008000047621486302079000014580031009060005720806320106057160400030"
# board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!