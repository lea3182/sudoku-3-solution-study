class Sudoku
  attr_reader :board, :length

  def initialize(initial_board_string, game_name = "Game", length = 9) #set up board
    @game_name = game_name
    @initial_board_string = initial_board_string
    @length = length
    @board = @initial_board_string.split("").each_slice(@length).to_a # represent board_string as a nested array: @board
  end

  def board_rows # retrieve board as rows
    @board
  end

  def get_row(row_number) # returns an array of the row values at this index
    board_rows[row_number]
  end

  def board_columns # retrieve board as columns
    @board.transpose
  end

  def get_column(column_number) # returns an array of the column values at this index
    board_columns[column_number]
  end

  def board_boxes # retrieve board as boxes
    boxes_array = [
      [@board[0][0], @board[0][1], @board[0][2], @board[1][0], @board[1][1], @board[1][2], @board[2][0], @board[2][1], @board[2][2]],
      [@board[0][3], @board[0][4], @board[0][5], @board[1][3], @board[1][4], @board[1][5], @board[2][3], @board[2][4], @board[2][5]],
      [@board[0][6], @board[0][7], @board[0][8], @board[1][6], @board[1][7], @board[1][8], @board[2][6], @board[2][7], @board[2][8]],
      [@board[3][0], @board[3][1], @board[3][2], @board[4][0], @board[4][1], @board[4][2], @board[5][0], @board[5][1], @board[5][2]],
      [@board[3][3], @board[3][4], @board[3][5], @board[4][3], @board[4][4], @board[4][5], @board[5][3], @board[5][4], @board[5][5]],
      [@board[3][6], @board[3][7], @board[3][8], @board[4][6], @board[4][7], @board[4][8], @board[5][6], @board[5][7], @board[5][8]],
      [@board[6][0], @board[6][1], @board[6][2], @board[7][0], @board[7][1], @board[7][2], @board[8][0], @board[8][1], @board[8][2]],
      [@board[6][3], @board[6][4], @board[6][5], @board[7][3], @board[7][4], @board[7][5], @board[8][3], @board[8][4], @board[8][5]],
      [@board[6][6], @board[6][7], @board[6][8], @board[7][6], @board[7][7], @board[7][8], @board[8][6], @board[8][7], @board[8][8]],
    ]
  end

  def get_box(box_number) # returns an array of the box values at this 'box number'
    board_boxes[box_number]
  end

  def get_box_of_cell(row, col) # returns the 'box number' of a cell at @board[row][index]
    if col <= 2
      if row <= 2
        0
      elsif row <= 5
        3
      else # row <= 8
        6
      end
    elsif col <= 5
      if row <= 2
        1
      elsif row <= 5
        4
      else # row <= 8
        7
      end
    else # row <= 8
      if row <= 2
        2
      elsif row <= 5
        5
      else # row <= 8
        8
      end
    end
  end

  def check_row(row, col)
    row_array = get_row(row)  # single array that holds all the values of cell's row
    row_array.each do |cell|
      if cell.class != Array
        @board[row][col].delete(cell)
      end
    end

    if @board[row][col].length == 1
      @board[row][col] = @board[row][col][0]
    end
  end

  def check_column(row, col)
    column_array = get_column(col)
    column_array.each do |cell|
      if cell.class != Array#@board[row][col].include?(cell)
        @board[row][col].delete(cell)
      end
    end

    if @board[row][col].length == 1
      @board[row][col] == @board[row][col][0]
    end
  end

  def check_box(row, col)
    box_number = get_box_of_cell(row, col)
    box_array = get_box(box_number)

    box_array.each do |cell|  #
      if cell.class != Array # && cell.match(/([1-9])/)
        @board[row][col].delete(cell)
      end
    end

    if @board[row][col].length == 1
      @board[row][col] = @board[row][col][0]
    end
  end

  def solve!
    10.times do
      linear_solve
    end

    singular_occurrence_solve

    10.times do
      linear_solve
    end

    singular_occurrence_solve

    10.times do
      linear_solve
    end

    singular_occurrence_solve

    10.times do
      linear_solve
    end

    singular_occurrence_solve

    10.times do
      linear_solve
    end

    singular_occurrence_solve

    10.times do
      linear_solve
    end

    singular_occurrence_solve

    10.times do
      linear_solve
    end

    singular_occurrence_solve

    10.times do
      linear_solve
    end

    singular_occurrence_solve

    10.times do
      linear_solve
    end

    singular_occurrence_solve

    10.times do
      linear_solve
    end

    singular_occurrence_solve

    10.times do
      linear_solve
    end

    singular_occurrence_solve

        10.times do
      linear_solve
    end

    singular_occurrence_solve

        10.times do
      linear_solve
    end

    singular_occurrence_solve

        10.times do
      linear_solve
    end

    singular_occurrence_solve

        10.times do
      linear_solve
    end

    singular_occurrence_solve

        10.times do
      linear_solve
    end

    singular_occurrence_solve

        10.times do
      linear_solve
    end

    singular_occurrence_solve

        10.times do
      linear_solve
    end

    singular_occurrence_solve
    # p "Total iterations = #{counter}"
  end

  def linear_solve
    row = 0 # the row we are in
    col = 0 # the column we are in

    while row < @length
      current_square = @board[row][col]

      if ("1".."9").include? current_square
        # do nothing
      elsif current_square == "0"
        @board[row][col] = ("1".."9").to_a
      elsif current_square.class == Array
        check_row(row, col)
        check_column(row, col)
        check_box(row, col)
      else
        puts "ERROR ERROR ERROR"
      end

      if col < @length - 1 # count through rows
        col += 1
      else
        col = 0
        row += 1
      end
    end
  end

  def singular_occurrence_solve # DOES NOT WORK. BUMMER
    row = 0
    col = 0

    while row < @length
      current_square = @board[row][col]
      if current_square.class == String
        # do nothing
      elsif current_square.class == Array
        break if singular_check_row(row, col)
        # singular_check_col(row, col)
        # singular_check_box(row, col)
      else
        puts "ERROR ERROR"
      end

      if col < @length - 1 # count through rows
        col += 1
      else
        col = 0
        row += 1
      end
    end
  end

  def singular_check_row(row, col)
    found = false
    row_array = get_row(row)
    only_arrays = []
    row_array.each {|cell|
      #p cell
      next if row_array.index(cell) == col
      if cell.class == Array
        # p "ARRAY LINE RUNNING"
        only_arrays << cell
      end
    }
    # p "only_arrays before flatten: #{only_arrays}"
    only_arrays.flatten!
    # p "only_arrays AFTER flatten: #{only_arrays}"

    index = 0
    current_square = @board[row][col]
    while index < current_square.length
      candidate = current_square[index]
      # p "candidate: #{candidate}"
      if only_arrays.any? {|cell| cell == candidate}
        # p "only_arrays includes candidate"
      else
        # p "SINGULAR! SINGULAR!"
        # p "row #{row} col #{col}"
        @board[row][col] = candidate
        found = true
        break
      end
      index += 1
    end
    found
  end

  def print_board_as_string # Challenge gist asked for this
    board_as_string = ""
    @board.each {|row|
      row.each {|cell|
        board_as_string += cell
      }
    }
    board_as_string
  end

  def solved?
    p board
    board_2 = @board.transpose
    test_1 = @board.map do |row|
      row.each do |cell|
          if cell.kind_of?(Array)
            puts "Dude, this thing is full of arrays."
            return false
          end
        end
          row.inject {|k,v| k+= v}
        end
    test_2 = board_boxes.map do |row|
      row.each do |cell|
          if cell.kind_of?(Array)
            puts "Dude, this thing is full of arrays."
            return false
          end
        end
        row.inject {|k,v| k+= v}
        end
    test_3 = board_boxes.map do |row|
      row.each do |cell|
        if cell.kind_of?(Array)
            puts "Dude, this thing is full of arrays."
            return false
          end
        end
          row.inject {|k,v| k+= v}
      end

    test_1.each { |i| return true if i == 45}
    test_2.each { |i| return true if i == 45}
    test_3.each { |i| return true if i == 45}
    if true
      puts"Awwwww yeah, problem solved."
    else
      puts "Your numbers are fucked."
    end
  end

  def print_board
    printable = @board.map do |row|
      row.map {|cell| (cell.class == Array) ? cell = "*" : cell}
    end

    title = "          Sudoku #{@game_name}"
    title_lines = "==========================="
    horiz_grid_lines = "--------+---------+--------"

    puts
    puts title
    puts title_lines
    puts "#{printable[0][0]}  #{printable[0][1]}  #{printable[0][2]} | #{printable[0][3]}  #{printable[0][4]}  #{printable[0][5]} | #{printable[0][6]}  #{printable[0][7]}  #{printable[0][8]} "
    puts "#{printable[1][0]}  #{printable[1][1]}  #{printable[1][2]} | #{printable[1][3]}  #{printable[1][4]}  #{printable[1][5]} | #{printable[1][6]}  #{printable[1][7]}  #{printable[1][8]} "
    puts "#{printable[2][0]}  #{printable[2][1]}  #{printable[2][2]} | #{printable[2][3]}  #{printable[2][4]}  #{printable[2][5]} | #{printable[2][6]}  #{printable[2][7]}  #{printable[2][8]} "
    puts horiz_grid_lines
    puts "#{printable[3][0]}  #{printable[3][1]}  #{printable[3][2]} | #{printable[3][3]}  #{printable[3][4]}  #{printable[3][5]} | #{printable[3][6]}  #{printable[3][7]}  #{printable[3][8]} "
    puts "#{printable[4][0]}  #{printable[4][1]}  #{printable[4][2]} | #{printable[4][3]}  #{printable[4][4]}  #{printable[4][5]} | #{printable[4][6]}  #{printable[4][7]}  #{printable[4][8]} "
    puts "#{printable[5][0]}  #{printable[5][1]}  #{printable[5][2]} | #{printable[5][3]}  #{printable[5][4]}  #{printable[5][5]} | #{printable[5][6]}  #{printable[5][7]}  #{printable[5][8]} "
    puts horiz_grid_lines
    puts "#{printable[6][0]}  #{printable[6][1]}  #{printable[6][2]} | #{printable[6][3]}  #{printable[6][4]}  #{printable[6][5]} | #{printable[6][6]}  #{printable[6][7]}  #{printable[6][8]} "
    puts "#{printable[7][0]}  #{printable[7][1]}  #{printable[7][2]} | #{printable[7][3]}  #{printable[7][4]}  #{printable[7][5]} | #{printable[7][6]}  #{printable[7][7]}  #{printable[7][8]} "
    puts "#{printable[8][0]}  #{printable[8][1]}  #{printable[8][2]} | #{printable[8][3]}  #{printable[8][4]}  #{printable[8][5]} | #{printable[8][6]}  #{printable[8][7]}  #{printable[8][8]} "
    puts
  end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# board_string = File.readlines('sample.unsolved.txt').first.chomp

# ======================== TESTS ============================================
game1 = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900", "Game No. 1")
game1.print_board
game1.solve!
game1.print_board
game1.solved?
p game1.print_board_as_string

game2 = Sudoku.new("005030081902850060600004050007402830349760005008300490150087002090000600026049503", "Game No. 2")
game2.print_board
game2.solve!
game2.print_board
game2.solved?
p game2.print_board_as_string

game3 = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900", "Game No. 3")
game3.print_board
game3.solve!
game3.print_board
game3.solved?
p game3.print_board_as_string

game4 = Sudoku.new("005030081902850060600004050007402830349760005008300490150087002090000600026049503", "Game No. 4")
game4.print_board
game4.solve!
game4.print_board
game4.solved?
p game4.print_board_as_string

game5 = Sudoku.new("290500007700000400004738012902003064800050070500067200309004005000080700087005109", "Game No. 5")
game5.print_board
game5.solve!
game5.print_board
game5.solved?
p game5.print_board_as_string

game6 = Sudoku.new("080020000040500320020309046600090004000640501134050700360004002407230600000700450", "Game No. 6")
game6.print_board
game6.solve!
game6.print_board
game6.solved?
p game6.print_board_as_string

game7 = Sudoku.new("608730000200000460000064820080005701900618004031000080860200039050000100100456200", "Game No. 7")
game7.print_board
game7.solve!
game7.print_board
game7.solved?
p game7.print_board_as_string

game8 = Sudoku.new("370000001000700005408061090000010000050090460086002030000000000694005203800149500", "Game No. 8")
game8.print_board
game8.solve!
game8.print_board
game8.solved?
p game8.print_board_as_string

game9 = Sudoku.new("000689100800000029150000008403000050200005000090240801084700910500000060060410000", "Game No. 9") # HERE WE FAIL. :(
game9.print_board
game9.solve!
game9.print_board
game9.solved?
p game9.print_board_as_string

game10 = Sudoku.new("030500804504200010008009000790806103000005400050000007800000702000704600610300500", "Game No. 10")
game10.print_board
game10.solve!
game10.print_board
game10.solved?
p game10.print_board_as_string

game11 = Sudoku.new("096040001100060004504810390007950043030080000405023018010630059059070830003590007", "Game No. 11")
game11.print_board
game11.solve!
game11.print_board
game11.solved?
p game11.print_board_as_string

# game12 = Sudoku.new("000075400000000008080190000300001060000000034000068170204000603900000020530200000", "Game No. 12")
# game12.print_board
# game12.solve!
# game12.print_board
# game12.solved?
# p game12.print_board_as_string

game13 = Sudoku.new("300000000050703008000028070700000043000000000003904105400300800100040000968000200", "Game No. 13")
game13.print_board
game13.solve!
game13.print_board
game13.solved?
p game13.print_board_as_string

# game14 = Sudoku.new("302609005500730000000000900000940000000000109000057060008500006000000003019082040", "Game No. 14")
# game14.print_board
# game14.solve!
# game14.print_board
# game14.solved?
# p game14.print_board_as_string