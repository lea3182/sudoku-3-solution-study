require 'pp'
require 'debugger'


class Sudoku
  attr_accessor :board
  def initialize(board_string)
    @board = Array.new(9){Array.new(9) {Hash.new()}}
    populate_board(board_string)
  end

  def display_board
    puts 'Welcome to Sudoku!'
    puts "      0   1   2   3   4   5   6   7   8 "
    @board.each_with_index do |row, row_index|
      # puts 'Row number is ' + row_index.to_s
      puts '' #if row_index != 0
      puts '      -----------------------------------'
      print "#{row_index}     "
      row.each do |cell|
        print cell["value"].to_s + ' | '
        # print cell["row_contains"]
        end
      end
      puts ''
      puts '      -----------------------------------'
  end

  def has_emptys?
    counter = 0
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        if cell["value"] == 0
          counter +=1
        end
      end
    end
    return counter
  end

  def populate_board(board_string)
    split_string = board_string.split("")
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
          cell["value"] =  split_string.shift.to_i
          cell["micro_x_coord"] = row_index % 3
          cell["micro_y_coord"] = col_index % 3
          cell["row_contains"] = []
          cell["col_contains"] = []
          cell["square_contains"] = []
      end
    end
    @board
  end

  def update_cells_row_key
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        row_contains = []
        @board[row_index].each do |element|
          row_contains << element["value"]
        end
        cell["row_contains"] << row_contains
        cell["row_contains"].flatten!
      end
    end
  end


  def update_cells_col_key
    board_transposed = @board.transpose
    board_transposed.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        row_contains = []
        board_transposed[row_index].each do |element|
          row_contains << element["value"]
        end
        cell["col_contains"] << row_contains
        cell["col_contains"].flatten!
      end
    end
  end


  def update_cells_square_key
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        micro_coords = [cell["micro_x_coord"], cell["micro_y_coord"]]
        square_contains = []
        case micro_coords
          when [0,0]
            square_contains << @board[row_index][col_index+1]["value"]
            square_contains << @board[row_index][col_index+2]["value"]
            square_contains << @board[row_index+1][col_index]["value"]
            square_contains << @board[row_index+2][col_index]["value"]
            square_contains << @board[row_index+1][col_index+1]["value"]
            square_contains << @board[row_index+2][col_index+1]["value"]
            square_contains << @board[row_index+1][col_index+2]["value"]
            square_contains << @board[row_index+2][col_index+2]["value"]
          when [0,1]
            square_contains << @board[row_index][col_index-1]["value"]
            square_contains << @board[row_index+1][col_index-1]["value"]
            square_contains << @board[row_index+2][col_index-1]["value"]
            square_contains << @board[row_index+1][col_index]["value"]
            square_contains << @board[row_index+2][col_index]["value"]
            square_contains << @board[row_index][col_index+1]["value"]
            square_contains << @board[row_index+1][col_index+1]["value"]
            square_contains << @board[row_index+2][col_index+1]["value"]
          when [0,2]
            square_contains << @board[row_index][col_index-1]["value"]
            square_contains << @board[row_index][col_index-2]["value"]
            square_contains << @board[row_index+1][col_index]["value"]
            square_contains << @board[row_index+2][col_index]["value"]
            square_contains << @board[row_index+1][col_index-1]["value"]
            square_contains << @board[row_index+2][col_index-1]["value"]
            square_contains << @board[row_index+1][col_index-2]["value"]
            square_contains << @board[row_index+2][col_index-2]["value"]
          when [1,0]
            square_contains << @board[row_index-1][col_index]["value"]
            square_contains << @board[row_index-1][col_index+1]["value"]
            square_contains << @board[row_index-1][col_index+2]["value"]
            square_contains << @board[row_index][col_index+1]["value"]
            square_contains << @board[row_index][col_index+2]["value"]
            square_contains << @board[row_index+1][col_index]["value"]
            square_contains << @board[row_index+1][col_index+1]["value"]
            square_contains << @board[row_index+1][col_index+2]["value"]
          when [1,1]
            square_contains << @board[row_index-1][col_index-1]["value"]
            square_contains << @board[row_index-1][col_index]["value"]
            square_contains << @board[row_index-1][col_index+1]["value"]
            square_contains << @board[row_index][col_index-1]["value"]
            square_contains << @board[row_index][col_index+1]["value"]
            square_contains << @board[row_index+1][col_index-1]["value"]
            square_contains << @board[row_index+1][col_index]["value"]
            square_contains << @board[row_index+1][col_index+1]["value"]
          when [1,2]
            square_contains << @board[row_index-1][col_index-2]["value"]
            square_contains << @board[row_index][col_index-2]["value"]
            square_contains << @board[row_index+1][col_index-2]["value"]
            square_contains << @board[row_index-1][col_index-1]["value"]
            square_contains << @board[row_index][col_index-1]["value"]
            square_contains << @board[row_index+1][col_index-1]["value"]
            square_contains << @board[row_index-1][col_index]["value"]
            square_contains << @board[row_index+1][col_index]["value"]
          when [2,0]
            square_contains << @board[row_index-2][col_index]["value"]
            square_contains << @board[row_index-1][col_index]["value"]
            square_contains << @board[row_index-2][col_index+1]["value"]
            square_contains << @board[row_index-1][col_index+1]["value"]
            square_contains << @board[row_index][col_index+1]["value"]
            square_contains << @board[row_index-2][col_index+2]["value"]
            square_contains << @board[row_index-1][col_index+2]["value"]
            square_contains << @board[row_index][col_index+2]["value"]
          when [2,1]
            square_contains << @board[row_index][col_index-1]["value"]
            square_contains << @board[row_index][col_index+1]["value"]
            square_contains << @board[row_index-1][col_index-1]["value"]
            square_contains << @board[row_index-1][col_index]["value"]
            square_contains << @board[row_index-1][col_index+1]["value"]
            square_contains << @board[row_index-1][col_index-1]["value"]
            square_contains << @board[row_index-2][col_index]["value"]
            square_contains << @board[row_index-2][col_index+1]["value"]
          when [2,2]
            square_contains << @board[row_index][col_index-1]["value"]
            square_contains << @board[row_index][col_index-2]["value"]
            square_contains << @board[row_index-1][col_index]["value"]
            square_contains << @board[row_index-1][col_index-1]["value"]
            square_contains << @board[row_index-1][col_index-2]["value"]
            square_contains << @board[row_index-2][col_index]["value"]
            square_contains << @board[row_index-2][col_index-1]["value"]
            square_contains << @board[row_index-2][col_index-2]["value"]
        end
        cell["square_contains"] << square_contains
        cell["square_contains"].flatten!.sort!
      end

    end

  end




  def solve!
    while has_emptys? != 0
      current_emptys = has_emptys?
      update_cells_row_key
      update_cells_col_key
      update_cells_square_key

      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index|
          if cell["value"] == 0
            cant_be_these = []
            possibilities = []
            cant_be_these << cell["row_contains"] << cell["col_contains"] << cell["square_contains"]
            cant_be_these.flatten!
            (1..9).each do | num |
              possibilities << num if !cant_be_these.include?(num)
            end
            if possibilities.length == 1
              cell["value"] = possibilities[0]
            end
          end
        end
      end
      newer_emptys = has_emptys?
      if newer_emptys == current_emptys
        p 'WARNING: This test case cannot be solved.'
        display_board
        abort
      end

    end
    display_board
    p 'SOLVED!'
  end









end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# board_string = File.readlines('sample.unsolved.txt').first.chomp

string1 =  "105802000090076405200400819019007306762083090000061050007600030430020501600308900"
string2 =  "005030081902850060600004050007402830349760005008300490150087002090000600026049503"
string3 =  "105802000090076405200400819019007306762083090000061050007600030430020501600308900"
string4 =  "005030081902850060600004050007402830349760005008300490150087002090000600026049503"
string5 =  "290500007700000400004738012902003064800050070500067200309004005000080700087005109"
string6 =  "080020000040500320020309046600090004000640501134050700360004002407230600000700450"
string7 =  "608730000200000460000064820080005701900618004031000080860200039050000100100456200"
string8 =  "370000001000700005408061090000010000050090460086002030000000000694005203800149500"
string9 =  "000689100800000029150000008403000050200005000090240801084700910500000060060410000"
string10  = "030500804504200010008009000790806103000005400050000007800000702000704600610300500"
string11  = "096040001100060004504810390007950043030080000405023018010630059059070830003590007"
string12  = "000075400000000008080190000300001060000000034000068170204000603900000020530200000"
string13  = "300000000050703008000028070700000043000000000003904105400300800100040000968000200"
string14  = "302609005500730000000000900000940000000000109000057060008500006000000003019082040"



board_string = '619030040270061008000047621486302079000014580031009060005720806320106057160400030'
non_empty = board_string.gsub('0','1')
one_empty = '609238745274561398853947621486352179792614583531879264945723816328196457167485932'
game = Sudoku.new(string14)
game.display_board
game.solve!
# game.display_board






# p game.board[0][6]["row_contains"] == [6, 1, 9, 0, 3, 0, 0, 4, 0]
# p game.board[5][3]["row_contains"] == [0, 3, 1, 0, 0, 9, 0, 6, 0]
# p game.board[0][0]["row_contains"] == [6, 1, 9, 0, 3, 0, 0, 4, 0]

# p game.board[0][0]["col_contains"] == [6, 2, 0, 4, 0, 0, 0, 3, 1]
# p game.board[0][6]["col_contains"] == [0, 0, 6, 0, 5, 0, 8, 0, 0]
# p game.board[5][3]["col_contains"] == [0, 0, 0, 3, 0, 0, 7, 1, 4]

# p game.board[2][5]["square_contains"] == [0, 0, 0, 0, 1, 3, 4, 6]
# p game.board[7][7]["square_contains"] == [8,0,6,0,7,0,3,0].sort!
# p game.board[6][2]["square_contains"] == [0,3,1,0,2,6,0,0].sort!
# p game.board[4][1]["square_contains"] == [4,8,6,0,0,0,3,1].sort!

# p game.has_emptys? == true



