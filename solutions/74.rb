class Sudoku
  def initialize(board_string)
    @board_string = board_string.split("")
    @size = Math.sqrt(board_string.length).floor
    @sub_size = Math.sqrt(@size).floor
    @board = board_string.split("")
    @region_0 = []
    @region_1 = []
    @region_2 = []
    @region_3 = []
    @region_4 = []
    @region_5 = []
    @region_6 = []
    @region_7 = []
    @region_8 = []
    #@board = Array.new(@size) {Array.new(@sub_size) { |row| @board.shift(@sub_size) }}
    create_lousy_board
  end

  def create_lousy_board
    #puts "INIT BOARD: #{@board}"
    @board_array = []

    regions_0_3_6_array = []
    regions_1_4_7_array = []
    regions_2_5_8_array = []

    @board.each_index do |index|
      array = []
      if index % 9 == 0
        array << @board[index]
        array << @board[index + 1]
        array << @board[index + 2]
        regions_0_3_6_array << array
      elsif index % 9 == 3
        array << @board[index]
        array << @board[index + 1]
        array << @board[index + 2]
        regions_1_4_7_array << array
      elsif index % 9 == 6
        array << @board[index]
        array << @board[index + 1]
        array << @board[index + 2]
        regions_2_5_8_array << array
      end
    end

    regions_0_3_6_array.each_index do |row|
      if row < 3
        @region_0 << regions_0_3_6_array[row]
      elsif row >= 3 && row < 6
        @region_3 << regions_0_3_6_array[row]
      else
        @region_6 << regions_0_3_6_array[row]
      end
    end

    regions_1_4_7_array.each_index do |row|
      if row < 3
        @region_1 << regions_1_4_7_array[row]
      elsif row >= 3 && row < 6
        @region_4 << regions_1_4_7_array[row]
      else
        @region_7 << regions_1_4_7_array[row]
      end
    end

    regions_2_5_8_array.each_index do |row|
      if row < 3
        @region_2 << regions_2_5_8_array[row]
      elsif row >= 3 && row < 6
        @region_5 << regions_2_5_8_array[row]
      else
        @region_8 << regions_2_5_8_array[row]
      end
    end

    @board_array << @region_0 << @region_1 << @region_2 << @region_3 << @region_4 <<
    @region_5 << @region_6 << @region_7 << @region_8

    @board_array
    # puts "BOARD: #{@board_array}"
  end

  def solve!
    all_possible = (1..@size).map { |num| num.to_s}
    @changed_board = false

    10.times do
    #while @changed_board == false
      @board_array.each_index do |region_index|
        # puts "REGION_INDEX: #{region_index}"
        @board_array[region_index].each_index do |row_index|
          # puts "ROW_INDEX: #{row_index}"
          cell = @board_array[region_index][row_index]
          # @board_array[region_index][row_index].each_with_index do |col, col_index|
          cell.each_with_index do |col, col_index|
            p "1. region_index: #{region_index}, row_index: #{row_index}, col_index: #{col_index}"
            @disqualified_numbers = []
            if col == "0"
              p "2. region_index: #{region_index}, row_index: #{row_index}, col_index: #{col_index}"

              # p "col_index: #{col_index}"
              @disqualified_numbers << get_row(region_index, row_index)
              # puts "1. @disqualified_numbers (row): #{@disqualified_numbers}"
              @disqualified_numbers << get_column(region_index, col_index)
              # puts "2. @disqualified_numbers (col): #{@disqualified_numbers}"
              @disqualified_numbers << get_region(region_index)
              # puts "3. @disqualified_numbers (region): #{@disqualified_numbers}"
              @disqualified_numbers.flatten!.uniq!.sort!.delete("0")
              # puts "4. @disqualified_numbers (region): #{@disqualified_numbers}"
              possible_numbers = all_possible - @disqualified_numbers
              p "possible_numbers: #{possible_numbers}"

              if possible_numbers.length == 1
                p "3. region_index: #{region_index}, row_index: #{row_index}, col_index: #{col_index}"
                cell[col_index] = possible_numbers[0]
                @changed_board = true
              end # If 115
            end #If 100
            @changed_board = false
          end # Do 97
        end # Do 93
      @changed_board = true
      end # Do 91
    #end #While
    end # 100.times
    @board_array.flatten(1)
    output = ""
    @board_string = @board_array.flatten.each_slice(@size){|row| output += row.join(" ") + "\n" } #need to re-order arrays before joining
    # need to re-assign @board_string to a new string with newly solved cells to pass to row and col
  end # def_solve


  def get_row(region_index, row_num)
    @all_rows = []
    start = 0


    @size.times do
      @all_rows << @board_string.slice(start, @size)
      start+=@size
    end

    rows = @all_rows.dup

    if region_index < 3
      rows[row_num]
    elsif region_index < 6
      rows[row_num + 3]
    else
      rows[row_num + 6]
    end
  end

  def get_column(region_index, col_num)
    #puts "region_index: #{region_index}"
    col_num = col_num.to_i
    @columns = @all_rows.transpose

    case region_index
    when 0, 3, 6
      @columns[col_num]
    when 1, 4, 7
      @columns[col_num + 3]
    else #2, 5, 8
      @columns[col_num + 6]
    end
  end

  def get_region(region_num)
    @board_array[region_num]
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    puts "PUTSING THE BOARD"
    @current_board = @board_array.dup
  end

  # to_s for simple board
  # def to_s
  #   return @board_array.map { |row| row.join(" ") }.join("\n")
  # end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('set-01_sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
# game.solve!

# puts "BOARD: #{game}"
puts game.solve!
# p game
# p game.get_row(2)
# p game.get_column(1)
# p game.get_region(0)