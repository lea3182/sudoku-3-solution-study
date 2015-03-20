require 'pry'
require 'pp'
require 'set'


class Sudoku
  attr_reader :board, :nine_digits
  def initialize(board_string)
    @board = feeder(board_string)
    @nine_digits = []
  end

  def feeder(integer)
    integer.to_s.split('').each_slice(9).to_a.each do |array|
      array.map! {|string| string.to_i}
    end
  end

  def solve!
    replace_zeros

    i=0 # failsafe against infinite loop
    until !check_for_sets || i == 100# Or there have been no changes. When we figure out how that might work.
      fix_all_cells
      count_digits
      i+=1
    end

    return @board
  end

  def replace_zeros
    @board.each do |row|
      row.map! { |x| x == 0 ? Set.new(1..9) : x }
    end
  end

  def check_for_sets
    @board.flatten.any? { |i| i.is_a? Set }
  end

  def fix_all_cells
    @board.each_with_index do |row, row_ix|
      row.each_with_index do |cell, col_ix|
        fix_cell(row_ix, col_ix, cell)
      end
    end
  end

  def fix_cell(row_ix, col_ix, cell)
    if cell.class == Set
      impossible = check_fucking_shit(row_ix, col_ix)
      @board[row_ix][col_ix] = generate_potential_answers(impossible)
    end
  end

  def generate_potential_answers(set_of_impossibilities)
    potential_answers = Set.new(1..9).difference(set_of_impossibilities)
    if potential_answers.size == 1
      potential_answers.to_a[0]
    else
      potential_answers
    end
  end

  def check_fucking_shit(row_ix, col_ix)
    # nov_ix = divine_nov(row_ix, col_ix)

    array_of_impossibilities =
    check_row(row_ix) +
    check_col(col_ix) +
    check_nov(row_ix, col_ix) +
    @nine_digits

    array_of_impossibilities.to_set
  end

  def check_row(row_n)
    @board[row_n].select {|i| (1..9).to_a.include? i}
  end

  def check_col(col_n)
    column = []
    @board.each do |row|
      column << row[col_n]
    end
    column.select {|i| (1..9).to_a.include? i}
  end

  def check_nov(row_ix, col_ix)
    nov =[]
    @board.each_with_index do |r, ri|
      r.each_with_index do |c, ci|
        nov << c if (ri/3 == row_ix/3) && (ci/3 == col_ix/3)
      end
    end
    nov
  end

  #   split_arr = @board.map {|row| row.each_slice(3).to_a}
  #   nov_board = Array.new(9) {[]}

  #   split_arr.each_with_index do |row, row_ix|
  #     case row_ix
  #     when 0..2
  #       nov_board[0] << row[0]
  #       nov_board[1] << row[1]
  #       nov_board[2] << row[2]
  #     when 3..5
  #       nov_board[3] << row[0]
  #       nov_board[4] << row[1]
  #       nov_board[5] << row[2]
  #     when 6..8
  #       nov_board[6] << row[0]
  #       nov_board[7] << row[1]
  #       nov_board[8] << row[2]
  #     end
  #   end
  #   nov_board.map {|i| i.flatten}[nov_n].select {|i| (1..9).to_a.include? i}
  # end

  # def divine_nov(r_ix, c_ix) #figures out which novrent this index falls into
  #   key = [r_ix/3, c_ix/3]

  #   nov_hash = {
  #     [0,0] => 0,
  #     [0,1] => 1,
  #     [0,2] => 2,
  #     [1,0] => 3,
  #     [1,1] => 4,
  #     [1,2] => 5,
  #     [2,0] => 6,
  #     [2,1] => 7,
  #     [2,2] => 8
  #   }

  #   nov_hash[key]
  # end

  def count_digits
    (1..9).each do |digit|
      if @board.flatten.count(digit) == 9
        @nine_digits << digit
      end
    end
  end





  # def digit_counter(digit)
  #   @board.flatten.inject {|memo, object| object == digit ? memo + 1 : memo}
  # end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  # def to_s

  # end
end



# => Test Code:
# array = feeder(105802000090076405200400819019007306762083090000061050007600030430020501600308900)
# pp array
# p array1 = array[0]
# p checker(array1)

puzzles = %w{105802000090076405200400819019007306762083090000061050007600030430020501600308900
005030081902850060600004050007402830349760005008300490150087002090000600026049503
105802000090076405200400819019007306762083090000061050007600030430020501600308900
005030081902850060600004050007402830349760005008300490150087002090000600026049503
290500007700000400004738012902003064800050070500067200309004005000080700087005109
080020000040500320020309046600090004000640501134050700360004002407230600000700450
608730000200000460000064820080005701900618004031000080860200039050000100100456200
370000001000700005408061090000010000050090460086002030000000000694005203800149500
000689100800000029150000008403000050200005000090240801084700910500000060060410000}
# 030500804504200010008009000790806103000005400050000007800000702000704600610300500
# 096040001100060004504810390007950043030080000405023018010630059059070830003590007
# 000075400000000008080190000300001060000000034000068170204000603900000020530200000
# 300000000050703008000028070700000043000000000003904105400300800100040000968000200
# }

s = Sudoku.new(puzzles[-1])

s.solve!


#binding.pry

puzzles.each_with_index do |puzzle, index|
  sudoku = Sudoku.new(puzzle)

  pp "Original #{index+1}: #{sudoku.board}"
  pp "Solved #{index+1}: #{sudoku.solve!}"
end



#  sudoku = Sudoku.new(105802000090076405200400819019007306762083090000061050007600030430020501600308900)


# sudoku.count_digits
# p sudoku.nine_digits


# p sudoku.board




# pp sudoku.solve!
# pp sudoku.board
# p "divine_nov tests"
# p divine_nov(0,0) == 0
# p divine_nov(1,3) == 1
# p divine_nov(2,6) == 2
# p divine_nov(3,1) == 3
# p divine_nov(4,4) == 4
# p divine_nov(5,7) == 5
# p divine_nov(6,2) == 6
# p divine_nov(7,5) == 7
# p divine_nov(8,8) == 8

# p "check_fucking_shit tests"
# p sudoku.check_fucking_shit(0,0) == Set.new([1,2,4,5,6,7,8,9])

# p "generate_potential_answers tests"

# # p sudoku.generate_potential_answers(Set.new([1,2,3,4,5,6,7,8])) == 9

# p sudoku.replace_zero(sudoku.board)
# p sudoku.check_for_sets
