require 'pry'
require 'minitest/autorun'

class TestSudoku < Minitest::Test
  def setup
     @test_board = Sudoku.new("---26-7-168--7--9-19---45--82-1---4---46-29---5---3-28--93---74-4--5--367-3-18---")
  end
  def test_row_conflict
    assert_equal true, @test_board.row_conflict?(0,6)
  end
  def test_column_conflict
    assert_equal true, @test_board.column_conflict?(0, 8)
  end
  def test_which_box
    assert_equal 1, @test_board.which_box(2,2)
    assert_equal 2, @test_board.which_box(2,5)
    assert_equal 3, @test_board.which_box(2,8)
    assert_equal 4, @test_board.which_box(5,2)
    assert_equal 5, @test_board.which_box(5,5)
    assert_equal 6, @test_board.which_box(5,8)
    assert_equal 7, @test_board.which_box(8,2)
    assert_equal 8, @test_board.which_box(8,5)
    assert_equal 9, @test_board.which_box(8,8)

  end
  def test_box_conflict
    assert_equal true, @test_board.box_conflict?(0,0 ,9)
    assert_equal true, @test_board.box_conflict?(0,3 ,7)
    assert_equal true, @test_board.box_conflict?(0,6 ,9)
    assert_equal true, @test_board.box_conflict?(3,0 ,2)
    assert_equal true, @test_board.box_conflict?(3,3 ,3)
    assert_equal true, @test_board.box_conflict?(3,6 ,9)
    assert_equal true, @test_board.box_conflict?(6,0 ,7)
    assert_equal true, @test_board.box_conflict?(6,3 ,3)
    assert_equal true, @test_board.box_conflict?(6,6 ,3)

  end
  def test_conflict
    assert_equal false, @test_board.row_conflict?(4,3) || @test_board.column_conflict?(8,3) || @test_board.box_conflict?(4,8,3)
  end
end


class Sudoku
  attr_accessor :board_string, :grid
  def initialize(board_string)
    @board_string = board_string
    @grid = to_grid(board_string)
  end

  def solve
    row_indx = 0
    grid.each do |row|
      col_indx = 0
      row.each do  |element|

        if element.class == Array
          element.delete_if do |target|
            row_conflict?(row_indx, target) || column_conflict?(col_indx, target)  || box_conflict?(row_indx, col_indx, target)
          end
        else
         element
        end
        col_indx +=1
      end
      row_indx += 1
    end
    fill_matches
    puts self.to_s + "\n\n"
    sleep 1
    move_to_home!
    clear_screen!
    solve unless solved?
  end

  def fill_matches
    grid.each do |row|
      row.map! do | element|
        if element.length == 1
          element[0].to_s
        else
          element
        end
      end
    end
  end

  def to_s
    grid.map do |row|
      row.map do |cell|
        cell.is_a?(Array) ? "0" : cell
      end.join(" ")
    end.join("\n")
  end

  def row_conflict?(row, target)
    grid[row].include?(target.to_s)
  end

  def column_conflict?(column, target)
    grid.transpose[column].include?(target.to_s)
  end

  def box_conflict?(row, column, target)
    case which_box(row, column)
    when 1
      grid[0][0..2].include?(target.to_s) || grid[1][0..2].include?(target.to_s) || grid[2][0..2].include?(target.to_s)
    when 2
    grid[0][3..5].include?(target.to_s) || grid[1][3..5].include?(target.to_s) || grid[2][3..5].include?(target.to_s)
    when 3
    grid[0][6..8].include?(target.to_s) || grid[1][6..8].include?(target.to_s) || grid[2][6..8].include?(target.to_s)
  when 4
    grid[3][0..2].include?(target.to_s) || grid[4][0..2].include?(target.to_s) || grid[5][0..2].include?(target.to_s)
    when 5
      #binding.pry
    grid[3][3..5].include?(target.to_s) || grid[4][3..5].include?(target.to_s) || grid[5][3..5].include?(target.to_s)
    when 6
    grid[3][6..8].include?(target.to_s) || grid[4][6..8].include?(target.to_s) || grid[5][6..8].include?(target.to_s)
    when 7
    grid[6][0..2].include?(target.to_s) || grid[7][0..2].include?(target.to_s) || grid[8][0..2].include?(target.to_s)
    when 8
    grid[6][3..5].include?(target.to_s) || grid[7][3..5].include?(target.to_s) || grid[8][3..5].include?(target.to_s)
    when 9
    grid[6][6..8].include?(target.to_s) || grid[7][6..8].include?(target.to_s) || grid[8][6..8].include?(target.to_s)
    end
  end

  def which_box(row , column)
    if row <= 2
      if column <= 2
        1
      elsif column <= 5
        2
      else
        3
      end
    elsif row <= 5
      if column <= 2
        4
      elsif column <= 5
        5
      else
        6
      end
    else
      if column <= 2
        7
      elsif column <= 5
        8
      else
        9
      end
    end
  end

  # def board
  #   # UPDATES board with method#solve's changes
  # end


  def to_grid(string)
    #binding.pry
    sudoku_board = string.split("").each_slice(9).to_a
    sudoku_board.each do |row|
      row.map! do |element|
        if element == "-"
          element = [*1..9]
        else
          element = element
        end
      end
    end
    sudoku_board
  end
  def clear_screen!
    print "\e[2J"
  end

  def move_to_home!
    print "\e[H"
  end
  def solved?
    grid.flatten.length == 81
  end
end
# binding.pry

