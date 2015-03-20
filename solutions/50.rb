SudokuNode = Struct.new(:value, :possibles)

class Sudoku
  SIZE = 9
  def initialize(board_string)
    @letters = board_string.chars
    @board = []
    @letters.each_with_index do |letter, index|
      node = SudokuNode.new
      node.value = letter
      @board << node
    end
  end

  def solve!
    @board.each_with_index do |node, index|
      if node.value == "0"
        taken_nums = [get_indices(index, 'row'),get_indices(index, 'column'),get_indices(index, 'cell')].flatten.uniq
        taken_nums.delete('0')
        nums = ("1".."9").to_a
        avail_nums = nums - taken_nums
        node.possibles = avail_nums
        if node.possibles.length == 1
          node.value = node.possibles[0]
        end
      end
    end
  puts @board
  end

 def get_indices(index, type)
    case type
      when "row"
        get_row_by_index(index)
      when "column"
        get_column_by_index(index)
      when "cell"
        get_cell_by_index(index)
    end
  end

  def get_row_by_index(index)
    values = []
    first = index-(index%SIZE)
    SIZE.times do |i|
      values << @letters[first+i]
    end
    return values
  end

  def get_column_by_index(index)
    count = index/SIZE.floor
    value = index-(count*SIZE)
    values = []
    SIZE.times do
      values << @letters[value]
      value+=SIZE
    end
    return values
  end

  def get_cell_by_index(index)
    values = []
    indices = [0, 1, 2, 9, 10, 11, 18, 19, 20]
    while !indices.include?(index)
      indices.map! { |i| i+=3 }
    end
    SIZE.times do |i|
      values << @letters[indices[i]]
    end
    return values
  end
end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
#   def board

#   end
# end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
#board_string = File.readlines('sample.unsolved.txt').first.chomp
board_string = "619030040270061008000047621486302079000014580031009060005720806320106057160400030"

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

# puts game.board


# TESTS

# 105802000090076405200400819019007306762083090000061050007600030430020501600308900
# 005030081902850060600004050007402830349760005008300490150087002090000600026049503
# 105802000090076405200400819019007306762083090000061050007600030430020501600308900
# 005030081902850060600004050007402830349760005008300490150087002090000600026049503
# 290500007700000400004738012902003064800050070500067200309004005000080700087005109
# 080020000040500320020309046600090004000640501134050700360004002407230600000700450
# 608730000200000460000064820080005701900618004031000080860200039050000100100456200
# 370000001000700005408061090000010000050090460086002030000000000694005203800149500
# 000689100800000029150000008403000050200005000090240801084700910500000060060410000
# 030500804504200010008009000790806103000005400050000007800000702000704600610300500
# 096040001100060004504810390007950043030080000405023018010630059059070830003590007
# 000075400000000008080190000300001060000000034000068170204000603900000020530200000
# 300000000050703008000028070700000043000000000003904105400300800100040000968000200
# 302609005500730000000000900000940000000000109000057060008500006000000003019082040