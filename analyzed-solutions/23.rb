# NOUNS
# Setter
# Player
# Board
# Tile
# Box (block of 9 tiles)
# Row
# Column

# Useful Methods
# array.transpose - turns array of arrays into array of rows and columns
# array.uniq

# Rough Psuedocode
# Every tile has possibilities 1-9. Hash has number as key and array of relatives as value
# Every tile is a key in a hash, its value is an array containing pointers to row, col and box
# Array of relatives for tile populated with all the values in corresponding row, col and box.
# Array of relatives is uniqued then iterated through to find what value is not present. Value is
# pushed to a solution array

# Less Rough Psuedocode
#______________________
#
# Initialize
#-----------
#  Create tile hash 0=>[6], 1 =>[1,2,3,4] etc
#  Create block hash (hardcoded)
#___________
#
# Solve!
#-----------
# Iterate through tile hash
#   Iterate through 1..9
#     if int is not equal to any relatives, push it to possibilities
#   If there is only one possibility, push it to solution array
#___________
#
# Board
#-----------
#
#
#
#
#______________________

class Sudoku
  def initialize(board_string)
    @tiles = Hash[(0..80).map { |key| [key, []] }] #Array of index and possibilities
    @given_values = []
    @board_string = board_string
  end

  def solve!
    @given_values = @board_string.split("")
    @given_values = @given_values.collect{|s| s.to_i}
    for i in 0..@given_values.length-1 do #Populate @tiles with value or possible values (1-9)
      if @given_values[i] == 0
        @tiles[i] = Array(1..9)
      else
        @tiles[i] = @given_values[i]
      end
    end
    check_relatives
  end

  def check_relatives
    @tiles.each do |index, possible_values| # @tiles[index] = possible_values
       if possible_values.is_a? Array
        # CHECK ROW
        rows = @given_values.each_slice(9).to_a
        @tiles[index] = @tiles[index] & rows[index/9] # (index/9) is corrosponding row, "&" eliminates commonalities
        # CHECK COL
        cols = @given_values.each_slice(9).to_a.transpose
        @tiles[index] = @tiles[index] & cols[index%9]
        # CHECK BOX
        boxes = get_boxes
        #p "Tile Value: #{@tiles[index]} Corrosponding box values: #{boxes[get_box_index(index/9, index%9)]}"
        #@tiles[index] = @tiles[index] & boxes[get_box_index(index/9, index%9)]
       end
    end
    #p @tiles
  end

  def get_boxes
    boxes = []
    for i in 0..8
      boxes << [@given_values[i*3], @given_values[i*3+1], @given_values[i*3+2], @given_values[i*3+9], @given_values[i*3+10], @given_values[i*3+11], @given_values[i*3+18], @given_values[i*3+19], @given_values[i*3+20]]
    end

    boxes.each do |box|
      box.each do |value|
        p "box: #{box} ******* value: #{value}"
      end
    end

    boxes
  end

  def get_box_index row, col
    if row >= 0 && row <= 2 # Either box 0,1,2
      if col >= 0 && col <= 2
        return 0
      elsif col >= 3 && col <= 5
        return 1
      else
        return 2
      end
    elsif row >= 3 && row <= 5 # Either box 3,4,5
      if col >= 0 && col <= 2
        return 3
      elsif col >= 3 && col <= 5
        return 4
      else
        return 5
      end
    else # Either box 6,7,8
      if col >= 0 && col <= 2
        return 6
      elsif col >= 3 && col <= 5
        return 7
      else
        return 8
      end
    end
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board

  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('set-01_sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

puts game.board