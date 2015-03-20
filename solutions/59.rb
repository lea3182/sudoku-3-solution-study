
# BEGIN VERSION 1 with group:
=begin

# Pseudoode

# Class Sudoku
  # Initialize
    # - empty slot
    # - number 1-9
    # - board
  # solve
    # - IF first 8 indices includes? 1
    #   - IF includes? 2
    # - ELSE next 8 indices
  #board


require 'pry'

class Sudoku
  attr_accessor :board_string, :board, :col_board

  def initialize(board_string)
    @board_string = board_string
    @board = []
    @row_nums = []
    @col_nums = []

  end

  def solve

    @board.each_with_index do |value,index|
      @row_nums << get_row(index)
    end
    puts "row value"
    p @row_nums

    @col_board = @board.transpose

    @col_board.each_with_index do |value,index|
      @col_nums << get_col(index)
    end
    puts"col value"
    p @col_nums






  end
  def match_row(element,row_index)
    @row_nums[row_index].include?(element)
  end
  def match_col(element,col_index)
    @col_nums[row_index].include?(element)
  end

  def match_box(x,y)


  end

  def get_row(row_index)
    @board[row_index] - ['-']
  end

  def get_col(row_index)
    @col_board[row_index] - ['-']
  end

  def get_box(box_index)

  end




  def get_box(x_cord,y_cord)

    # if x_cord < 3 && y_cord <3
    #   box = 1
    # elsif x_cord < 6 && y_cord < 3
    #   box =2
    # elsif x_cord < 9 && y_cord < 3
    #   box = 3
    # elsif x_cord < 3 && y_cord < 6
    #   box =4
    # elsif x_cord < 6 && y_cord < 6
    #   box = 5
    # elsif x_cord < 9 && y_cord < 6
    #   box =6
    # elsif x_cord < 3 && y_cord < 9
    #   box =7
    # elsif x_cord < 6 && y_cord < 9
    #   box = 8
    # elsif x_cord < 9 && y_cord < 9
    #   box =9
    # end
    # case
    # when box =1


    # end

  end

  def board
    to_grid(@board_string.split(''))
    @board.each do |row|
     p row
   end
 end

  # Returns a nicely formatted string representing the current state of the board
  def to_s
  end

  def to_grid(board_array)
    board_array.each_slice(9){|x|  @board << x}

  end
end

=end
# END VERSION 1

# ===========================================================

# BEGIN VERSION 2  SOLO:

# Pseudoode

# Create a METHOD to solve the puzzle
# UNTIL game is solved
    # FIND ALL empty slots in original string
        # FOR EACH empty slot do something
            # FIND how many options there are for that slot
                # IF there is only 1 option for that slot
                    # SET the slot with the option value

# Create a METHOD that returns all the remaining options for a slot
  # option nums must be 1-9
    # FIND nums that are already in the row
      # REMOVE them from options
    # FIND nums that are already in the column
     # REMOVE them from options
    # FIND nums that are already in the box
     # REMOVE them from options
    # RETURN remaining options (remove row, column, box nums from options)

# INITIALIZE an array of existing row nums
  # FOR EACH slot access its index
  # ACCESS individual indices of each row (there are 81 slots in board, there are 9 rows in board, there are 9 consecutive slots in each row, we can divide 81 by 9 to get each row index)(create a separate method for this calculation)
    # IF the index of the slot matches the index of the row(slot == index of the row index)
      # ADD the slot to the array of row_nums
    # RETURN the array of existing row nums

# INITIALIZE an array of existing column nums
  # FOR EACH slot access its index
  # ACCESS individual indices of each column given a slot index (there are 81 slots in board, each slot must be in one of the nine consecutive rows, each row index is also a column index, we can divide 81 by 9 where the remainder will be equiv to the column index)(create a separate method for this calculation)
    # IF the index of the slot matches the index of the column(slot == index of the column index)
      # ADD the slot to the array of row_nums
  # RETURN the array of existing column nums

# INITIALIZE an array of existing box nums
    # FOR EACH slot access its index
    # ACCESS individual indices of each box given a slot index (there are 81 slots in board, we can hard code all slots that are in each box)(create a separate method for this calculation)
    # FIND the box(key) that includes to the given slot(value)
      # IF the index of the slot matches the index of the box(slot == index of the box index)
        # ADD the slot to the array of box_nums
    # RETURN the array of existing box nums


# Create a METHOD that accesses all empty slots
# In other words, based on some condition, create a new collection of things that only contains the values of the things when the condition is true
# INITIALIZE an array of empty slots
  # FOR EACH empty slot access its index
    # IF slot_num is 0
      # ADD its index in the collection of empty slots

  # Create a METHOD that returns a nicely formatted string representing the current state of the board



require 'pry'

class Sudoku
  def initialize(board_string)
    # array of integers
    # Ruby knows to convert anything that isn't an integer to a 0
    @slots = board_string.chars.map { |s| s.to_i }
    @board_string = board_string
  end

  def solve
    # UNTIL game is solved
    until solved?
      # FIND ALL empty slots in original string
      # FOR EACH empty slot do something
      empty_slots.each do |slot|
        # FIND how many options there are for that slot
        options = options_for(slot)
        # IF there is only 1 option for that slot
        if options.length == 1
          # SET the slot with the option value
          board[slot] = options.first
        end
      end
    end
  end

  def options_for(slot)
    # option nums must be 1-9
    options = (1..9).to_a
    # FIND nums that are already in the row
    row_nums = get_row_nums_for(slot)
    # REMOVE them from options
    # options = options - row_nums

    # FIND nums that are already in the column
    column_nums = get_column_nums_for(slot)
    # REMOVE them from options
    # options = options - column_nums

    # FIND nums that are already in the box
    box_nums = get_box_nums_for(slot)
    # REMOVE them from options
    # options = options - box_nums

    # RETURN remaining options (remove row, column, box nums from options)
    options - row_nums - column_nums - box_nums
  end

  def get_row_nums_for(slot_index)
    # INITIALIZE an array of existing row nums
    row_nums = []
    row_index = row_index(slot_index)
    # FOR EACH slot access its index
    board.each_with_index do |slot, index|
      # IF the index of the slot matches the index of the row(slot == index of the row index)
      if row_index(index) == row_index
        # ADD the slot to the array of row_nums
        row_nums << slot
      end
    end
    # RETURN the array of existing row nums
    row_nums
  end

  # ACCESS individual indices of each row (there are 81 slots in board, there are 9 rows in board, there are 9 consecutive slots in each row, we can divide 81 by 9 to get each row index)
  def row_index(slot)
    slot / 9
  end

  def get_column_nums_for(slot_index)
    # INITIALIZE an array of existing column nums
    column_nums = []
    column_index = column_index(slot_index)
    # FOR EACH slot access its index
    board.each_with_index do |slot, index|
      # IF the index of the slot matches the index of the column(slot == index of the column index)
      if column_index(index) == column_index
        # ADD the slot to the array of column_nums
        column_nums << slot
      end
    end
    # RETURN the array of existing column nums
    column_nums
  end

  # ACCESS individual indices of each column given a slot index (there are 81 slots in board, each slot must be in one of the nine consecutive rows, each row index is also a column index, we can divide 81 by 9 where the remainder will be equiv to the column index)
  def column_index(slot)
    slot % 9
  end

  def get_box_nums_for(slot_index)
    # INITIALIZE an array of existing box nums
    box_nums = []
    box_index = box_index(slot_index)
    # FOR EACH slot access its index
    board.each_with_index do |slot, index|
      # IF the index of the slot matches the index of the box(slot == index of the box index)
      if box_index(index) == box_index
        # ADD the slot to the array of box_nums
        box_nums << slot
      end
    end
    # RETURN the array of existing box nums
    box_nums
  end

  # ACCESS individual indices of each box given a slot index (there are 81 slots in board, we can hard code all slots that are in each box)
  def box_index(slot)
    box_index = {
                  0 => [0, 1, 2, 9, 10, 11, 18, 19, 20],
                  1 => [3, 4, 5, 12, 13, 14, 21, 22, 23],
                  2 => [6, 7, 8, 15, 16, 17, 24, 25, 26],
                  3 => [27, 28, 29, 36, 37, 38, 45, 46, 47],
                  4 => [30, 31, 32, 39, 40, 41, 48, 49, 50],
                  5 => [33, 34, 35, 42, 43, 44, 51, 52, 53],
                  6 => [54, 55, 56, 63, 64, 65, 72, 73, 74],
                  7 => [57, 58, 59, 66, 67, 68, 75, 76, 77],
                  8 => [60, 61, 62, 69, 70, 71, 78, 79, 80]
    }
    # FIND the box(key) that includes to the given slot(value)
    box_index.keys.find { |k| box_index[k].include?(slot) }
  end
  # OR we can use a formula but this is an extra calculation
  # def box_index(slot)
  #   ( ( (slot/9) / 3 ) * 3 ) + ( (slot%9) / 3 )
  # end


  def solved?
    empty_slots.empty?  # => same as empty_slots.length == 0
  end

  # based on some condition, create a new collection of things that only contains the nums of the things when the condition is true
  def empty_slots
    # INITIALIZE an array of empty slots
    empty_slots_indices = []
    # FOR EACH empty slot access its index
    @slots.each_with_index do |slot_num, index|
      # IF slot_num is 0
      if slot_num == 0
        # ADD its index in the collection of empty slots
        empty_slots_indices << index
      end
    end
    empty_slots_indices
  end

  def board
    @slots
  end

  # Returns a nicely formatted string representing the current state of the board

  def to_s
    puts "---------------------------------------"
    row = @slots.each_slice(9) { |slice| puts "|  " + slice.join(" | ") + "  |"}
    puts "---------------------------------------"
  end

end


# END VERSION 2 SOLO