#Sudocode

# Input: 81 Strings
# Output: A display of the solution board

# Starting from the top: go row by row then see if there is a row with only one empty cell
# Search the row and see which number is missing
# Do same for columns then boxes (quadrants of 9 cells)

# Pick a value and search first box to check if that value is present
# if yes then skip to next box
# if no then pop up empty cells
# Take first empty cell ask it if there is a row/column conflict if yes go to next empty cell if no
# set that value and go next box
# Once you got to all the boxes increment the value of chosen number by one

#
class Sudoku  #board

  attr_reader :board, :rows, :cols, :boxes

  def initialize(board_string)

    input_values = board_string.split(//)

    @board = input_values.map.with_index{|value, index| Cell.new(value, index)}

    @rows = @board.map{|cell| cell.index/9 }
    @cols = @board.map{|cell| cell.index%9 }
    @boxes = @board.map{|cell| (@rows[cell.index]/3) * 3 + @cols[cell.index]/3}

    @empty_ids = @board.select{|cell| cell.is_empty?}
    @empty_ids.map!{|cell| cell.index}

  end

  def board
    puts "---------------------"
    horizontal_bar_counter = 0
    @board.each_slice(9) do |cell_array|
      values_array = cell_array.map{|cell| cell.value}
      values_array.insert(3, "|")
      values_array.insert(7, "|")
      puts values_array.join(" ")
      horizontal_bar_counter += 1
      if horizontal_bar_counter == 3
        puts "---------------------"
        horizontal_bar_counter = 0
      end

    end
  end

  def fill(id)
    row_vals = get_row_values(id)
    col_vals = get_col_values(id)
    box_vals = get_box_values(id)

    possible_values = [1,2,3,4,5,6,7,8,9].map{|num| num.to_s}

    possible_values.select!{|num| !row_vals.include?(num)}
    possible_values.select!{|num| !col_vals.include?(num)}
    possible_values.select!{|num| !box_vals.include?(num)}


    if possible_values.length == 1
      @board[id].value = possible_values[0]
      #puts "value became : #{@board[id].value} at index #{id}"
      # board
      @empty_ids.shift
      true
    else
      #puts "Can't fill, possible_values is #{possible_values}"
      @empty_ids.rotate!
      false
    end
  end

  def get_row_values(id)
    row_buddy_values = []
    @rows.each_with_index do |row_num, index|
      if row_num == @rows[id]
        row_buddy_values << @board[index].value
      end
    end
    row_buddy_values
  end

  def get_col_values(id)
    col_buddy_values = []
    @cols.each_with_index do |col_num, index|
      if col_num == @cols[id]
        col_buddy_values << @board[index].value
      end
    end
    col_buddy_values
  end

  def get_box_values(id)
    box_buddy_values = []
    @boxes.each_with_index do |box_num, index|
      if box_num == @boxes[id]
        box_buddy_values << @board[index].value
      end
    end
    box_buddy_values
  end

  def next_empty_id
    @empty_ids.first
  end


  def solve!
    counter = 0
    while next_empty_id && counter < 1000
      fill(next_empty_id)
      counter += 1
    end
    if counter < 999
      puts "solved one :"
      board
    end
    # puts "row values = #{get_row_values(9)}"
    # puts "col values = #{get_col_values(10)}"
    # puts "get_box_values = #{get_box_values(74)}"
    # puts "possible fills for #{fill(4)}"

  end
end

class Cell
  attr_accessor :value
  attr_reader :index

  def initialize(value, index)
   @value = value
   @index = index
  end

  def is_empty?
    @value == "0"
  end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.

all_board_strings = File.read('set-01_sample.unsolved.txt').split(/\n/)
# board_string = File.readlines('set-01_sample.unsolved.txt').pop.chomp

all_games =  all_board_strings.map{|board_string| Sudoku.new(board_string)}

all_games.each {|game| game.solve!}


# game = Sudoku.new(board_string)

# puts game.board
# # Remember: this will just fill out what it can and not "guess"
# game.solve!

# puts game.board

#puts game.board