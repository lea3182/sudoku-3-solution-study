class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def pink
    colorize(35)
  end

  def white
    colorize(37)
  end

  def background_blue
    colorize(44)
  end
end

class Sudoku
  def initialize(board_string)
    @board_string = board_string
    @row = calculate_row
    @row_solutions = calculate_row
    @column = calculate_column
    @box = calculate_box
  end

  def calculate_row
    # result = []
    # board_string_array = @board_string.split('')
    # 9.times do
    #   result << board_string_array.shift(9)
    # end
    # result
    @board_string.split('')
                 .each_slice(9)
                 .to_a.map{|row| row.map(&:to_i) }
  end

  def calculate_column
    @row.transpose
    # result = Array.new(1){Array.new(1)}*9
    # @row.each do |row|

    # end
    # p result
  end

  def calculate_box
    result = Array.new(1){Array.new(1)}*9
    board_string_array = @row.flatten

    result[0] = board_string_array.shift(3)
    result[1] = board_string_array.shift(3)
    result[2] = board_string_array.shift(3)

    result[0] << board_string_array.shift(3)
    result[1] << board_string_array.shift(3)
    result[2] << board_string_array.shift(3)

    result[0] << board_string_array.shift(3)
    result[1] << board_string_array.shift(3)
    result[2] << board_string_array.shift(3)

    result[3] = board_string_array.shift(3)
    result[4] = board_string_array.shift(3)
    result[5] = board_string_array.shift(3)

    result[3] << board_string_array.shift(3)
    result[4] << board_string_array.shift(3)
    result[5] << board_string_array.shift(3)

    result[3] << board_string_array.shift(3)
    result[4] << board_string_array.shift(3)
    result[5] << board_string_array.shift(3)


    result[6] = board_string_array.shift(3)
    result[7] = board_string_array.shift(3)
    result[8] = board_string_array.shift(3)

    result[6] << board_string_array.shift(3)
    result[7] << board_string_array.shift(3)
    result[8] << board_string_array.shift(3)

    result[6] << board_string_array.shift(3)
    result[7] << board_string_array.shift(3)
    result[8] << board_string_array.shift(3)

    result[0].flatten!
    result[1].flatten!
    result[2].flatten!
    result[3].flatten!
    result[4].flatten!
    result[5].flatten!
    result[6].flatten!
    result[7].flatten!
    result[8].flatten!

    result

  end

  def solve!
    @row = calculate_row
    @row.each do |row|
      system "clear"
      puts "board not solved...".red
      board
      # sleep(0.1)

      index_to_replace = row.map(&:to_i)
      .map
      .with_index{|cell,idx| cell.zero? ? idx : nil}
      .compact

      possible_solutions = (1..9).to_a - row.map(&:to_i)
      # puts "----"
      # p index_to_replace

      # possible_solutions = (1..9).to_a
      # index_to_replace = []
      # replace_with = []
      # row.each do |cell|
      #   if cell == "0"
      #     index_to_replace << row.index(cell)
      #   else
      #     possible_solutions.delete(cell.to_i)
      #   end
      # end
      # # puts "for row index #{@row.index(row)} this is the indexes to replace #{index_to_replace}"
      # puts
      # puts "for row index #{@row.index(row)} this is the possible solution #{possible_solutions}"

      index_to_replace.each do |this_index|
        possible_solutions = possible_solutions.shuffle
        row[this_index.to_i] = possible_solutions[0]
      end
    end

    boxes_add_to_45 = nil
    rows_add_to_45 = nil
    columns_add_to_45 = nil

    calculate_column.each do |column|
      if column.reduce(:+) == 45
        columns_add_to_45 = true
      else
        columns_add_to_45 = false
      end
    end

    @row.each do |row|
      if row.reduce(:+) == 45
        rows_add_to_45 = true
      else
        rows_add_to_45 = false
      end
    end

    calculate_box.each do |box|
      if box.reduce(:+) == 45
        boxes_add_to_45 = true
      else
        boxes_add_to_45 = false
      end
    end

    if boxes_add_to_45 == true && rows_add_to_45 == true && columns_add_to_45 == true
      system "clear"
      puts "BOARD SOLVED!!!!!!".green
      board
    else
      board
      solve!

    end
  end



  def board
    # puts "Unsolved Puzzle"
    # row_count = 0
    # puts "-------------------------"
    # @row.each do |row|
    #   row_count += 1
    #   print "| "
    #   row_as_string = row.join(' ')
    #   row_as_string[5] = " | "
    #   row_as_string[13] = " | "
    #   print row_as_string
    #   print " |"
    #   puts
    #   if row_count % 3 == 0
    #     puts "------------------------"
    #   end
    # end
    # puts


    row_count = 0
    puts "-------------------------".yellow
    @row.each do |row|
      row_count += 1
      print "| ".yellow
      row_as_string = row.join(' ')
      row_as_string[5] = " | "
      row_as_string[13] = " | "
      print row_as_string.white
      print " |".yellow
      puts
      if row_count % 3 == 0
        puts "------------------------".yellow
      end
    end
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# board_string = File.readlines('sample.unsolved.txt').first.chomp
board_string = "105802000090076405200400819019007306762083090000061050007600030430020501600308900" #last should be 2
game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
# game.solve!
game.solve!
