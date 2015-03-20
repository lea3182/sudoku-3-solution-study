require 'pry'
require 'pry-nav'
require 'Matrix'

class Sudoku
  attr_accessor :board
  def initialize(board_string)
    converted = board_string.split('').map {|num| num.to_i}
    @board = Array.new(9) {converted.shift(9)}
    raise "This board does not have enough numbers to be valid" unless board_string.length == 81
    @board.map! do |row|
      row.map! do |cell|
        if cell == 0
          cell = [1,2,3,4,5,6,7,8,9]
        else
          cell
        end
      end
    end
  end

  def row_checker(row_index, test_num)
    @board[row_index].include?(test_num)
  end

  def column_checker(col_index, test_num)
    columns = @board.transpose
    columns[col_index].include?(test_num)
  end

def solve!
    until solved? do
      @board.each_with_index do |row, r_index|
        row.each_with_index do |cell, c_index|
          if cell.is_a? Array
            cell.map do |test_number|
                square = 0
                if (0..2).include?(r_index) && (0..2).include?(c_index)
                  square = 0
                elsif (0..2).include?(r_index) && (3..5).include?(c_index)
                  square = 1
                elsif (0..2).include?(r_index) && (6..8).include?(c_index)
                  square =2
                elsif (3..5).include?(r_index) && (0..2).include?(c_index)
                  square = 3
                elsif (3..5).include?(r_index) && (3..5).include?(c_index)
                  square = 4
                elsif (3..5).include?(r_index) && (6..8).include?(c_index)
                  square = 5
                elsif (6..8).include?(r_index) && (0..2).include?(c_index)
                  square = 6
                elsif (6..8).include?(r_index) && (3..5).include?(c_index)
                  square = 7
                elsif (6..8).include?(r_index) && (6..8).include?(c_index)
                  square = 8
                end

              if row_checker(r_index,test_number)
                cell.delete(test_number)
                @board[r_index][c_index] = cell
              elsif column_checker(c_index,test_number)
                cell.delete(test_number)
                @board[r_index][c_index] = cell
              elsif box_checker(square,test_number)
                    cell.delete(test_number)
              end

              # row_possibilities(r_index)
              # column_possibilities(c_index)

              if cell.length == 1
                @board[r_index][c_index] = cell[0]
              end
            end # test number map
            end # if cell is array
          end # each with index for column
        end # each with index row
        print_it
        sleep(0.5)
      end
  end

  # def row_possibilities(r_index)
  #   rposs = @board.dup
  #   rposs1 = rposs[r_index].delete_if {|x| x.is_a? Integer}
  #   print @board
  #   9.times do |x|
  #     rcount = rposs1.flatten.count(x+1)
  #     if rcount == 1
  #       unique = x+1
  #     end
  #     @board[r_index].each do |y|
  #       if y.include?(unique)
  #         y = unique
  #       end
  #     end
  #   end
  # end

  # def column_possibilities(c_index)
  #   columns_check = @board.transpose
  #   cposs = columns_check[c_index].delete_if {|x| x.is_a? Integer}.flatten
  #   9.times do |x|
  #     ccount = cposs.count(x+1)
  #     if ccount == 1
  #       unique = x+1
  #     end
  #     columns_check[c_index].each do |y|
  #       if y.include?(unique)
  #         y = unique
  #       end
  #     end
  #   end
  # end


  def box_checker(box, test_number)

    box_board = [
                  box_1 = [@board[0][0],@board[0][1],@board[0][2],@board[1][0],@board[1][1],@board[1][2],@board[2][0],@board[2][1],@board[2][2]],
                  box_2 = [@board[0][3],@board[0][4],@board[0][5],@board[1][3],@board[1][4],@board[1][5],@board[2][3],@board[2][4],@board[2][5]],
                  box_3 = [@board[0][6],@board[0][7],@board[0][8],@board[1][6],@board[1][7],@board[1][8],@board[2][6],@board[2][7],@board[2][8]],
                  box_4 = [@board[3][0],@board[3][1],@board[3][2],@board[4][0],@board[4][1],@board[4][2],@board[5][0],@board[5][1],@board[5][2]],
                  box_5 = [@board[3][3],@board[3][4],@board[3][5],@board[4][3],@board[4][4],@board[4][5],@board[5][3],@board[5][4],@board[5][5]],
                  box_6 = [@board[3][6],@board[3][7],@board[3][8],@board[4][6],@board[4][7],@board[4][8],@board[5][6],@board[5][7],@board[5][8]],
                  box_7 = [@board[6][0],@board[6][1],@board[6][2],@board[7][0],@board[7][1],@board[7][2],@board[8][0],@board[8][1],@board[8][2]],
                  box_8 = [@board[6][3],@board[6][4],@board[6][5],@board[7][3],@board[7][4],@board[7][5],@board[8][3],@board[8][4],@board[8][5]],
                  box_9 = [@board[6][6],@board[6][7],@board[6][8],@board[7][6],@board[7][7],@board[7][8],@board[8][6],@board[8][7],@board[8][8]]
                ]

    case box
      when 0
        return box_1.delete_if{|x| x.is_a? Array}.include?(test_number)
      when 1
        return box_2.delete_if{|x| x.is_a? Array}.include?(test_number)
      when 2
        return box_3.delete_if{|x| x.is_a? Array}.include?(test_number)
      when 3
        return box_4.delete_if{|x| x.is_a? Array}.include?(test_number)
      when 4
        return box_5.delete_if{|x| x.is_a? Array}.include?(test_number)
      when 5
        return box_6.delete_if{|x| x.is_a? Array}.include?(test_number)
      when 6
        return box_7.delete_if{|x| x.is_a? Array}.include?(test_number)
      when 7
        return box_8.delete_if{|x| x.is_a? Array}.include?(test_number)
      when 8
        return box_9.delete_if{|x| x.is_a? Array}.include?(test_number)
    end
  end

  def solved?
    if @board.flatten.reduce(:+) == 405
      if @board[0].sort==@board[1].sort && @board[2].sort==@board[3].sort && @board[4].sort==@board[5].sort && @board[6].sort==@board[7].sort && @board[7].sort==@board[8].sort
        if @board.transpose[0].sort==@board.transpose[1].sort && @board.transpose[2].sort==@board.transpose[3].sort && @board.transpose[4].sort==@board.transpose[5].sort && @board.transpose[6].sort==@board.transpose[7].sort && @board.transpose[7].sort==@board.transpose[8].sort
          return true
        end
      end
    end
  end

  def print_it
    x = 0
    y = 0
    print "\e[H"
    print "\e[2J"
    print "\n"
    print "   \033[1;36m\SUDOKU SHAZAM \n"
    3.times do
      print "--------------------- \n"
      print "#{@board[x][y]} #{@board[x][y+1]} #{@board[x][y+2]} | #{@board[x][y+3]} #{@board[x][y+4]} #{@board[x][y+5]} | #{@board[x][y+6]} #{@board[x][y+7]} #{@board[x][y+8]} \n"
      x+=1
      print "#{@board[x][y]} #{@board[x][y+1]} #{@board[x][y+2]} | #{@board[x][y+3]} #{@board[x][y+4]} #{@board[x][y+5]} | #{@board[x][y+6]} #{@board[x][y+7]} #{@board[x][y+8]} \n"
      x+=1
      print "#{@board[x][y]} #{@board[x][y+1]} #{@board[x][y+2]} | #{@board[x][y+3]} #{@board[x][y+4]} #{@board[x][y+5]} | #{@board[x][y+6]} #{@board[x][y+7]} #{@board[x][y+8]} \n"
      x+=1
    end
    print "--------------------- \n"
    print "    Rick, Tyler \n"
    print "   Keenan, Mikee \n"
    print "\n"
  end

end

looking = Sudoku.new('370000001000700005408061090000010000050090460086002030000000000694005203800149500')

looking.solve!


#Guessing
#Clone board
#Iterate to first occurence of a possibilities array
#.sample the possibilities array and set it equal to the cell
#re enter main method and see if it allows puzzle to be solved
# if clone board is not solveable then reenter guess and try with new board