require 'pry'
require 'pry-nav'

class Sudoku
  attr_accessor :full_board
   def initialize(board_string)
    @board_string = board_string.to_s.split("")
    @full_board = (0..2).map { |tri_mini_square|
      (0..2).map {|tri_cell|
        (0..2).map {|mini_square|
          (0..2).map {|cell|
           Cell.new(@board_string.shift(), tri_mini_square, tri_cell, mini_square, cell)
          }
        }
      }
    }
  end

  def loop_mini_square(tri_mini_square, mini_square)
    (0..2).each{|tri_cell|
      (0..2).each{|cell|
        yield @full_board[tri_mini_square][tri_cell][mini_square][cell]
      }
    }
  end

  def loop_row(tri_mini_square, tri_cell)
    (0..2).each{|mini_square|
      (0..2).each{|cell|
         yield @full_board[tri_mini_square][tri_cell][mini_square][cell]
      }
    }
  end

  def loop_column(mini_square, cell)
    (0..2).each{|tri_mini_square|
      (0..2).each{|tri_cell|
         yield @full_board[tri_mini_square][tri_cell][mini_square][cell]
      }
    }
  end

  def loop_board
    (0..2).each{|tri_mini_square|
      (0..2).each{|tri_cell|
        loop_row(tri_mini_square,tri_cell){|cell|yield cell}
      }
    }
  end

  def solve!
    finished_cells = []
    something_changed = true
    until something_changed == false do
        # standard_method_changed_something = false
        loop_board do |cell|
          something_changed = false
          to_delete=[]
          cell.possibilities.each do |possibility|
            loop_row(cell.tri_mini_square_index, cell.tri_cell_index) do |row_cell|
                if row_cell.solution == possibility
                  to_delete << possibility
                  # standard_method_changed_something = true
                  finished_cells << 1 if cell.possibilities == []
                  something_changed = true
                end
              end
            loop_column(cell.mini_square_index, cell.cell_index) do |column_cell|
                  if column_cell.solution == possibility
                    to_delete << possibility
                    finished_cells << 1 if cell.possibilities == []
                    # standard_method_changed_something = true
                    something_changed = true
                end
            end
            loop_mini_square(cell.tri_mini_square_index, cell.mini_square_index) do |mini_square_cell|
                  if mini_square_cell.solution == possibility
                    to_delete << possibility
                    finished_cells << 1 if cell.possibilities == []
                    # standard_method_changed_something = true
                    something_changed = true
                end
            end
          end

            to_delete.each{|non_possibility| cell.possibilities.delete(non_possibility) if cell.possibilities.include?(non_possibility)}
            # puts "#{cell.tri_mini_square_index} , #{cell.tri_cell_index}, #{cell.mini_square_index} , #{cell.cell_index} : #{cell.possibilities}"
            cell.solution = cell.possibilities[0] if cell.possibilities.length == 1
            # cell.possibilities = [] if cell.solution != " "
        end

        # if standard_method_changed_something == false
        #   something_changed = check_matching_possibilities
        # end
        return if finished_cells.length == 81
        check_matching_possibilities if something_changed == false


   end
  end

  # def take_a_guess
  #     if true
  #       binding.pry
  #     end
  #     loop_board.find{|cell| cell.solution == " "}
  # end

  def check_matching_possibilities
    something_changed = true
    until something_changed == false
      loop_board do |cell|
          something_changed = false
          cell.possibilities.each do |possibility|
            loop_row(cell.tri_mini_square_index, cell.tri_cell_index) do |row_cell|
                if row_cell.possibilities.length > 1
                  if !row_cell.possibilities.include?possibility
                    cell.solution = possibility
                    cell.possibilities = []
                    something_changed = true
                  end
                end
            end
            loop_column(cell.mini_square_index, cell.cell_index) do |column_cell|
                if column_cell.possibilities.length > 1 and !column_cell.possibilities.include?possibility
                  cell.solution = possibility
                  cell.possibilities = []
                  something_changed = true
                end
            end
            loop_mini_square(cell.tri_mini_square_index, cell.mini_square_index) do |mini_square_cell|
                if mini_square_cell.solution.length > 1 and !column_cell.possibilities.include?possibility
                  cell.solution = possibility
                  cell.possibilities = []
                  something_changed = true
                end
            end
          end
      end
    end
    solve! if something_changed == false
  end


  def print_board
    i = 0
    a = 1
    loop_board do |cell|
      if i % 9 == 0
        print "\n  ------------------------------------------------------"
        print "| \n  |  #{cell.solution}  |"
      elsif a % 3 ==0
        print "  #{cell.solution}  |"
      else
        print "  #{cell.solution}  |"
      end
      i+=1
      a+=1
    end
    print "\n  ------------------------------------------------------"
  end
end



class Cell
  attr_accessor :solution, :possibilities
  attr_reader :tri_mini_square_index, :tri_cell_index, :mini_square_index, :cell_index
  def initialize(string, tri_mini_square, tri_cell, mini_square, cell)

    @possibilities = ["1","2","3","4","5","6","7","8","9"]
    @tri_mini_square_index = tri_mini_square
    @tri_cell_index = tri_cell
    @mini_square_index = mini_square
    @cell_index = cell

    if string.to_i == 0
      @solution = " "
    else
      @solution = string
      @possibilities = [string]
    end
  end
  def solved?
    if @possibilities.length <= 1
      @solution = @possibilities
    end
  end
end


# board1 = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
game_boards =       ["005030081902850060600004050007402830349760005008300490150087002090000600026049503", "105802000090076405200400819019007306762083090000061050007600030430020501600308900", "005030081902850060600004050007402830349760005008300490150087002090000600026049503", "290500007700000400004738012902003064800050070500067200309004005000080700087005109", "080020000040500320020309046600090004000640501134050700360004002407230600000700450", "608730000200000460000064820080005701900618004031000080860200039050000100100456200", "370000001000700005408061090000010000050090460086002030000000000694005203800149500", "000689100800000029150000008403000050200005000090240801084700910500000060060410000", "030500804504200010008009000790806103000005400050000007800000702000704600610300500", "096040001100060004504810390007950043030080000405023018010630059059070830003590007", "000075400000000008080190000300001060000000034000068170204000603900000020530200000", "300000000050703008000028070700000043000000000003904105400300800100040000968000200", "302609005500730000000000900000940000000000109000057060008500006000000003019082040"]
game_boards.each{|x|
board = Sudoku.new(x)
board.print_board
board.solve!
board.print_board
}
#  board1.loop_column(0,0){|cell|
#   puts cell.solution
#  }
#  board1.loop_row(0,0){|cell|
#   print cell.solution
#  }
#  board1.loop_column(0,0){|cell|
#   print cell.solution
#  }
#  board1.loop_mini_square(0,0){|cell|
#   print cell.solution
#  }
#  board1.loop_board{|cell|
#   print cell.solution
#  }

# board1.print_board
# board1.eliminate_possibilities
 # board1.loop_board{|cell|
 #  print cell.solution
 #  puts " #{cell.tri_mini_square_index} #{cell.tri_cell_index}  #{cell.mini_square_index} #{cell.cell_index}"
 # }
# board1.print_board
# print board1.loop_board{|cell| print cell.solution}

# board1.print_board
# board1.solve!

# board1.print_board



