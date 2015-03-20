class Sudoku
  attr_reader :master_board, :length

  def initialize(board_string, length = 9)
    @board_string = board_string
    @length = length
    @master_board = @board_string.split("").each_slice(@length).to_a # BOARD, as rows, maintain for clarity rows_array (see elsewhere)
    #@complete_number_set = ("1".."9").to_a
  end

  def board_rows # non destructive
    @master_board
  end

  def get_row(row_number)
    board_rows[row_number]
  end

  def board_columns # non destructive
    @master_board.transpose
  end

  def get_column(column_number)
    board_columns[column_number]
  end

  def board_boxes # non destructive
    boxes_array = [
      [@master_board[0][0], @master_board[0][1], @master_board[0][2], @master_board[1][0], @master_board[1][1], @master_board[1][2], @master_board[2][0], @master_board[2][1], @master_board[2][2]],
      [@master_board[0][3], @master_board[0][4], @master_board[0][5], @master_board[1][3], @master_board[1][4], @master_board[1][5], @master_board[2][3], @master_board[2][4], @master_board[2][5]],
      [@master_board[0][6], @master_board[0][7], @master_board[0][8], @master_board[1][6], @master_board[1][7], @master_board[1][8], @master_board[2][6], @master_board[2][7], @master_board[2][8]],
      [@master_board[3][0], @master_board[3][1], @master_board[3][2], @master_board[4][0], @master_board[4][1], @master_board[4][2], @master_board[5][0], @master_board[5][1], @master_board[5][2]],
      [@master_board[3][3], @master_board[3][4], @master_board[3][5], @master_board[4][3], @master_board[4][4], @master_board[4][5], @master_board[5][3], @master_board[5][4], @master_board[5][5]],
      [@master_board[3][6], @master_board[3][7], @master_board[3][8], @master_board[4][6], @master_board[4][7], @master_board[4][8], @master_board[5][6], @master_board[5][7], @master_board[5][8]],
      [@master_board[6][0], @master_board[6][1], @master_board[6][2], @master_board[7][0], @master_board[7][1], @master_board[7][2], @master_board[8][0], @master_board[8][1], @master_board[8][2]],
      [@master_board[6][3], @master_board[6][4], @master_board[6][5], @master_board[7][3], @master_board[7][4], @master_board[7][5], @master_board[8][3], @master_board[8][4], @master_board[8][5]],
      [@master_board[6][6], @master_board[6][7], @master_board[6][8], @master_board[7][6], @master_board[7][7], @master_board[7][8], @master_board[8][6], @master_board[8][7], @master_board[8][8]],
    ]
    boxes_array
  end

  def get_box(box_number)
    board_boxes[box_number]
  end

  def solve! # linear_solve (?) linear_search (?)
    x = 0 # horizontal movement. in relation to @master_board, x is the index of each element within the nested arrays.
    y = 0 # vertical movement. in relation to @master_board, y is the index of each nested array within the board array.

    while y < @length
      current_square = @master_board[x][y]
      case current_square
      when ("1".."9") # nothing
      when "0"
        # a lot of stuff
      when # []
        # a lot of stuff
      else
        puts "ERROR YO CHECK WHAT'S GOING ON"
        # raise Argument
      end

      if x < @length
        x += 1
      else
        x = 0
        y += 1
      end
    end
  end

  def view_cell # ?
  end
  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def print_board_as_string
    # "124654732352367052"
  end

  def print_board
  end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

# this board_string is equal to: (Each line is a different board.)
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

game = Sudoku.new(board_string)
game.board_rows.each {|row| p row}
p game.get_box(0)

# Remember: this will just fill out what it can and not "guess"
game.solve!

#puts game.master_board
