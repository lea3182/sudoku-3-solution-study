def welcome_header
  puts "=================================="
  puts "   WELCOME TO THE SUDOKU SOLVER"
  puts "=================================="
  puts "       work smart, not hard"
end

class Sudoku
  attr_reader :board

  def initialize(board_string)
    @board = board_string.chars.map do |zero|
     zero == "0" ? zero = "123456789" : zero
    end.each_slice(9).to_a

    @boxes = [
      [ get_row(0)[0..2], get_row(1)[0..2], get_row(2)[0..2] ].flatten, #box 0
      [ get_row(0)[3..5], get_row(1)[3..5], get_row(2)[3..5] ].flatten, #box 1
      [ get_row(0)[6..8], get_row(1)[6..8], get_row(2)[6..8] ].flatten, #box 2

      [ get_row(3)[0..2], get_row(4)[0..2], get_row(5)[0..2] ].flatten, #box 3
      [ get_row(3)[3..5], get_row(4)[3..5], get_row(5)[3..5] ].flatten, #box 4
      [ get_row(3)[6..8], get_row(4)[6..8], get_row(5)[6..8] ].flatten, #box 5

      [ get_row(6)[0..2], get_row(7)[0..2], get_row(8)[0..2] ].flatten, #box 6
      [ get_row(6)[3..5], get_row(7)[3..5], get_row(8)[3..5] ].flatten, #box 7
      [ get_row(6)[6..8], get_row(7)[6..8], get_row(8)[6..8] ].flatten  #box 8
      ]

  end

  # Access rows, columns, and boxes ---------------------------------
    def get_row(row_index)
      @board[row_index]
    end

    def get_column(column_index)
      @board.transpose[column_index]
    end

    def get_box(box_index)
      @boxes[box_index]
    end
  # ------------------------------------------------------------------

  # Micromethods for checking process ---------------------------------
    def check_row(number, cell, row)
      cell.delete!(number) if control_array(get_row(row)).include?(number)
    end

    def check_column(number, cell, column)
      cell.delete!(number) if control_array(get_column(column)).include?(number)
    end

    def check_box(number, cell, this_box)
      cell.delete!(number) if control_array(get_box(this_box)).include?(number)
    end

    def find_and_check_box(number, cell, box_coords)
      case box_coords
      when [0, 0]
        this_box = 0
        check_box(number, cell, this_box)
      when [0, 1]
        this_box = 1
        check_box(number, cell, this_box)
      when [0, 2]
        this_box = 2
        check_box(number, cell, this_box)
      when [1, 0]
        this_box = 3
        check_box(number, cell, this_box)
      when [1, 1]
        this_box = 4
        check_box(number, cell, this_box)
      when [1, 2]
        this_box = 5
        check_box(number, cell, this_box)
      when [2, 0]
        this_box = 6
        check_box(number, cell, this_box)
      when [2, 1]
        this_box = 7
        check_box(number, cell, this_box)
      else
        this_box = 8
        check_box(number, cell, this_box)
      end
    end

    def control_array(array)
      array.clone.delete_if {|element| element.length > 1}
    end
  # ------------------------------------------------------------------

  def run_solver
    0.upto(8).each do |row|
      0.upto(8).each do |column|
        cell = @board[row][column]
        cell.each_char do |number|
          if cell.length > 1
            check_row(number, cell, row)
            check_column(number, cell, column)
            find_and_check_box(number, cell, [row/3, column/3])
          end
          print_board = Marshal.load(Marshal.dump(@board))
          system("clear")
          welcome_header
          puts
          puts
          puts
          puts to_s(print_board)
        end
      end
    end
  end

  def solved?
    @board.all? { |row| row.map { |num| num.to_i }.reduce(:+) == (1..9).reduce(:+) }
  end

  def solve!(board=@board)
    system("say 'solving sudoku'")
    until solved?
      @previous_board = Marshal.load(Marshal.dump(board))
      p run_solver
      if board == @previous_board
        puts
        return "Sorry, I can't solve that one."
      end
    end
    puts
    puts "...aaaaannd DONE!"
    puts
    puts "That was easy. Just please don't make me start guessing..."
    puts
    return @board
  end

  def to_s(print_board)
    print_board.each do |row|
      row.map! do |cell|
        cell.length > 1 ? cell.chars.sample : cell
      end
    end
    print_board = print_board.join.gsub(/(\w{3})\D{0,1}(\w{3})\D{0,1}(\w{3})/, '| \1 | \2 | \3 |' + "\n")
    print_board = "+-----+-----+-----+\n" + print_board + "+-----+-----+-----+\n"
    print_board.insert(79, "\n+-----+-----+-----+")
    print_board.insert(159, "\n+-----+-----+-----+")
  end
end

# =====================================================================================================
# TESTS
# =====================================================================================================

board1 = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
board2 = Sudoku.new("005030081902850060600004050007402830349760005008300490150087002090000600026049503")
board3 = Sudoku.new("290500007700000400004738012902003064800050070500067200309004005000080700087005109")
board4 = Sudoku.new("080020000040500320020309046600090004000640501134050700360004002407230600000700450")
board5 = Sudoku.new("608730000200000460000064820080005701900618004031000080860200039050000100100456200")
board6 = Sudoku.new("370000001000700005408061090000010000050090460086002030000000000694005203800149500")

board7 = Sudoku.new("000689100800000029150000008403000050200005000090240801084700910500000060060410000")
board8 = Sudoku.new("030500804504200010008009000790806103000005400050000007800000702000704600610300500")

board9 = Sudoku.new("096040001100060004504810390007950043030080000405023018010630059059070830003590007")
boardA = Sudoku.new("000075400000000008080190000300001060000000034000068170204000603900000020530200000")
boardB = Sudoku.new("300000000050703008000028070700000043000000000003904105400300800100040000968000200")
boardC = Sudoku.new("302609005500730000000000900000940000000000109000057060008500006000000003019082040")


# p "Test 1: #{board1.solve!}"
# p "Test 2: #{board2.solve!}"
# p "Test 3: #{board3.solve!}"
# p "Test 4: #{board4.solve!}"
# p "Test 5: #{board5.solve!}"
# p "Test 6: #{board6.solve!}"
# p "Test 7: #{board7.solve!}"
# p "Test 8: #{board8.solve!}"
# p "Test 9: #{board9.solve!}"
# p "Test A: #{boardA.solve!}"
# p "Test B: #{boardB.solve!}"
# p "Test C: #{boardC.solve!}"
# p board1.solve!