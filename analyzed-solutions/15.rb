class Sudoku
  attr_reader :board_array, :box_array, :array_of_one_to_nine
  def initialize(board_string)
    #Convert board_string to 9x9 nested array - board_array

    @board_array = [[{"number" => board_string[0], "coordinate" => [0,0]},
                    {"number" => board_string[1], "coordinate" => [0,1]},
                    {"number" => board_string[2], "coordinate" => [0,2]},
                    {"number" => board_string[3], "coordinate" => [0,3]},
                    {"number" => board_string[4], "coordinate" => [0,4]},
                    {"number" => board_string[5], "coordinate" => [0,5]},
                    {"number" => board_string[6], "coordinate" => [0,6]},
                    {"number" => board_string[7], "coordinate" => [0,7]},
                    {"number" => board_string[8], "coordinate" => [0,8]}],
                    [{"number" => board_string[9], "coordinate" => [1,0]},
                    {"number" => board_string[10], "coordinate" => [1,1]},
                    {"number" => board_string[11], "coordinate" => [1,2]},
                    {"number" => board_string[12], "coordinate" => [1,3]},
                    {"number" => board_string[13], "coordinate" => [1,4]},
                    {"number" => board_string[14], "coordinate" => [1,5]},
                    {"number" => board_string[15], "coordinate" => [1,6]},
                    {"number" => board_string[16], "coordinate" => [1,7]},
                    {"number" => board_string[17], "coordinate" => [1,8]}],
                    [{"number" => board_string[18], "coordinate" => [2,0]},
                    {"number" => board_string[19], "coordinate" => [2,1]},
                    {"number" => board_string[20], "coordinate" => [2,2]},
                    {"number" => board_string[21], "coordinate" => [2,3]},
                    {"number" => board_string[22], "coordinate" => [2,4]},
                    {"number" => board_string[23], "coordinate" => [2,5]},
                    {"number" => board_string[24], "coordinate" => [2,6]},
                    {"number" => board_string[25], "coordinate" => [2,7]},
                    {"number" => board_string[26], "coordinate" => [2,8]}],
                    [{"number" => board_string[27], "coordinate" => [3,0]},
                    {"number" => board_string[28], "coordinate" => [3,1]},
                    {"number" => board_string[29], "coordinate" => [3,2]},
                    {"number" => board_string[30], "coordinate" => [3,3]},
                    {"number" => board_string[31], "coordinate" => [3,4]},
                    {"number" => board_string[32], "coordinate" => [3,5]},
                    {"number" => board_string[33], "coordinate" => [3,6]},
                    {"number" => board_string[34], "coordinate" => [3,7]},
                    {"number" => board_string[35], "coordinate" => [3,8]}],
                    [{"number" => board_string[36], "coordinate" => [4,0]},
                    {"number" => board_string[37], "coordinate" => [4,1]},
                    {"number" => board_string[38], "coordinate" => [4,2]},
                    {"number" => board_string[39], "coordinate" => [4,3]},
                    {"number" => board_string[40], "coordinate" => [4,4]},
                    {"number" => board_string[41], "coordinate" => [4,5]},
                    {"number" => board_string[42], "coordinate" => [4,6]},
                    {"number" => board_string[43], "coordinate" => [4,7]},
                    {"number" => board_string[44], "coordinate" => [4,8]}],
                    [{"number" => board_string[45], "coordinate" => [5,0]},
                    {"number" => board_string[46], "coordinate" => [5,1]},
                    {"number" => board_string[47], "coordinate" => [5,2]},
                    {"number" => board_string[48], "coordinate" => [5,3]},
                    {"number" => board_string[49], "coordinate" => [5,4]},
                    {"number" => board_string[50], "coordinate" => [5,5]},
                    {"number" => board_string[51], "coordinate" => [5,6]},
                    {"number" => board_string[52], "coordinate" => [5,7]},
                    {"number" => board_string[53], "coordinate" => [5,8]}],
                    [{"number" => board_string[54], "coordinate" => [6,0]},
                    {"number" => board_string[55], "coordinate" => [6,1]},
                    {"number" => board_string[56], "coordinate" => [6,2]},
                    {"number" => board_string[57], "coordinate" => [6,3]},
                    {"number" => board_string[58], "coordinate" => [6,4]},
                    {"number" => board_string[59], "coordinate" => [6,5]},
                    {"number" => board_string[60], "coordinate" => [6,6]},
                    {"number" => board_string[61], "coordinate" => [6,7]},
                    {"number" => board_string[62], "coordinate" => [6,8]}],
                    [{"number" => board_string[63], "coordinate" => [7,0]},
                    {"number" => board_string[64], "coordinate" => [7,1]},
                    {"number" => board_string[65], "coordinate" => [7,2]},
                    {"number" => board_string[66], "coordinate" => [7,3]},
                    {"number" => board_string[67], "coordinate" => [7,4]},
                    {"number" => board_string[68], "coordinate" => [7,5]},
                    {"number" => board_string[69], "coordinate" => [7,6]},
                    {"number" => board_string[70], "coordinate" => [7,7]},
                    {"number" => board_string[71], "coordinate" => [7,8]}],
                    [{"number" => board_string[72], "coordinate" => [8,0]},
                    {"number" => board_string[73], "coordinate" => [8,1]},
                    {"number" => board_string[74], "coordinate" => [8,2]},
                    {"number" => board_string[75], "coordinate" => [8,3]},
                    {"number" => board_string[76], "coordinate" => [8,4]},
                    {"number" => board_string[77], "coordinate" => [8,5]},
                    {"number" => board_string[78], "coordinate" => [8,6]},
                    {"number" => board_string[79], "coordinate" => [8,7]},
                    {"number" => board_string[80], "coordinate" => [8,8]}]]


    # declare array with elements 1-9 as an instance
    @array_of_one_to_nine = (1..9).to_a.map{|num| num.to_s}
    # declare array of coordinates for box1-9
    @box_one = [@board_array[0][0], @board_array[0][1], @board_array[0][2],
                @board_array[1][0], @board_array[1][1], @board_array[1][2],
                @board_array[2][0], @board_array[2][1], @board_array[2][2]]

    @box_two = [@board_array[0][3], @board_array[0][4], @board_array[0][5],
                @board_array[1][3], @board_array[1][4], @board_array[1][5],
                @board_array[2][3], @board_array[2][4], @board_array[2][5]]

    @box_three = [@board_array[0][6], @board_array[0][7], @board_array[0][8],
                @board_array[1][6], @board_array[1][7], @board_array[1][8],
                @board_array[2][6], @board_array[2][7], @board_array[2][8]]

    @box_four = [@board_array[3][0], @board_array[3][1], @board_array[3][2],
                @board_array[4][0], @board_array[4][1], @board_array[4][2],
                @board_array[5][0], @board_array[5][1], @board_array[5][2]]

    @box_five = [@board_array[3][3], @board_array[3][4], @board_array[3][5],
                @board_array[4][3], @board_array[4][4], @board_array[4][5],
                @board_array[5][3], @board_array[5][4], @board_array[5][5]]

    @box_six = [@board_array[3][6], @board_array[3][7], @board_array[3][8],
                @board_array[4][6], @board_array[4][7], @board_array[4][8],
                @board_array[5][6], @board_array[5][7], @board_array[5][8]]

    @box_seven = [@board_array[6][0], @board_array[6][1], @board_array[6][2],
                @board_array[7][0], @board_array[7][1], @board_array[7][2],
                @board_array[8][0], @board_array[8][1], @board_array[8][2]]

    @box_eight = [@board_array[6][3], @board_array[6][4], @board_array[6][5],
                @board_array[7][3], @board_array[7][4], @board_array[7][5],
                @board_array[8][3], @board_array[8][4], @board_array[8][5]]

    @box_nine = [@board_array[6][6], @board_array[6][7], @board_array[6][8],
                @board_array[7][6], @board_array[7][7], @board_array[7][8],
                @board_array[8][6], @board_array[8][7], @board_array[8][8]]

    # declare array of boxes containing box1-9
    @box_array = [@box_one, @box_two, @box_three, @box_four, @box_five, @box_six, @box_seven, @box_eight, @box_nine]

  end

  def solve!
    sum = 0
    until sum >= 405
      box_array.each do |box|
        # get missing value, store in variable containing array
        # find positions == 0
        empty_positions = box.select{|cell| cell["number"] == "0"}
        missing_values = find_missing_value(@array_of_one_to_nine, box).select{|cell| cell != "0"}

        # put hash here for now
        possible_positions = {}

        missing_values.each do |number|
          empty_positions.each do |position|
            # check if row or column of each empty position contains value
            if !check_row?(number, position["coordinate"][0]) && !check_column?(number, position["coordinate"][1])
              if possible_positions.has_key?(number)
                possible_positions[number] << position["coordinate"]
              else
                possible_positions[number] = [position["coordinate"]]
              end
            end
          end
        end

        possible_positions.each_key do |key|

          if possible_positions[key].length == 1
            x = possible_positions[key][0][0]
            y = possible_positions[key][0][1]
            board_array[x][y]["number"] = key
          end
        end
      end
      sum = 0
      @board_array.each do |row|
        row.each do |num|
          num["number"].to_i
          p sum += num["number"].to_i
        end
      end
    end
  end

  def find_missing_value(array_of_numbers1, array_of_hash2)
    array_of_numbers2 = []
    array_of_hash2.each do |hash|
      array_of_numbers2 << hash["number"]
    end
    (array_of_numbers1 + array_of_numbers2) - (array_of_numbers1 & array_of_numbers2)
  end

  def check_row?(value, row_index)
    nums_in_row = []
    board_array[row_index].each do |cell_hash|
      nums_in_row << cell_hash["number"]
    end
    nums_in_row.include? value
  end

  def check_column?(value, column_index)
    nums_in_col = []
    (0..8).each do |row_index|
    nums_in_col << board_array[row_index][column_index]["number"]
    end
    nums_in_col.include? value
  end

# Final Approach
  # until no value has been added
    # Loop through each box
        # get missing values
          # TBD - look up array#remove
        # find empty position
          # loop through the missing values
            # loop through position
              # check if row contains that value and check if column contains value
                # save as possible position for the value as hash (key = value, value = possible position)
            # if find hash with value count of one
              # add that missing value to the empty position
            # else
              # set no value added

  def board
    @board_array.each do |row|
      row.each do |hash|
        print hash["number"] + "\t"
      end
      puts ""
    end
  end
end




# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# board_string = File.readlines('sample.unsolved.txt').first.chomp

board_string = "105802000090076405200400819019007306762083090000061050007600030430020501600308900"

game = Sudoku.new(board_string)
# Remember: this will just fill out what it can and not "guess"
# game.solve!

# puts game.board
#p game.board_array
#p game.box_array
# p game.array_of_one_to_nine
game.board
game.solve!
puts "Solved"
game.board
game.check_row?("6", 0)

# First Approach
    # loop through board array (use each_with_index(x))
      # looop through each row (use each_with_index(y))
        # for each cell
          # get_all_cells horizontally(x coordinate)
          # get_all_cells vertically(x, coordinate y coordinate)
          # get_all_cells_in_box (TBD)
  # define #get_all_cells_horizontally(row_number)
    #
  # define #get_all_cells_vertically
  # define #get_all_cells_in_box

  # define #logically_necessary

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.

# Second Approach
  #solve!
    # Check each row
      # if fits "logically necessary"
        # add missing number
    # Check each column
      # if fits "logically necessary"
          # add missing number
    # Check each box
      # if fits "logically necessary"
          # add missing number
    # loop until no numbers were added

  #logically_necessary?
    # check if missing just one element (only one zero)
      # true
    # else
      # false

  #add_missing_number
    # 45 - sum of the entire row/column/box