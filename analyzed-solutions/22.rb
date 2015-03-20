class Sudoku
  attr_reader :puzzle

  @@boxes=[]

  @@boxes[0]=[[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
  @@boxes[1]=[[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]]
  @@boxes[2]=[[0,6],[0,7],[0,8],[1,6],[1,7],[1,8],[2,6],[2,7],[2,8]]

  @@boxes[3]=[[3,0],[3,1],[3,2],[4,0],[4,1],[4,2],[5,0],[5,1],[5,2]]
  @@boxes[4]=[[3,3],[3,4],[3,5],[4,3],[4,4],[4,5],[5,3],[5,4],[5,5]]
  @@boxes[5]=[[3,6],[3,7],[3,8],[4,6],[4,7],[4,8],[5,6],[5,7],[5,8]]

  @@boxes[6]=[[6,0],[6,1],[6,2],[7,0],[7,1],[7,2],[8,0],[8,1],[8,2]]
  @@boxes[7]=[[6,3],[6,4],[6,5],[7,3],[7,4],[7,5],[8,3],[8,4],[8,5]]
  @@boxes[8]=[[6,6],[6,7],[6,8],[7,6],[7,7],[7,8],[8,6],[8,7],[8,8]]

  def initialize(board_string)
    @puzzle = transform_puzzle_string_into_2d_array(board_string)
  end

  def solve!
    row_counter = 0
    while row_counter < 9
      column_counter = 0
      while column_counter < 9
        # p "in inner loop"
        current_value = @puzzle[row_counter][column_counter]
         #p "current value: #{current_value}:[#{row_counter}][#{column_counter}]"
        if current_value != nil #move to next value in the row if current value is already assigned
          column_counter += 1
        else
          remaining = (1..9).to_a
          row = @puzzle[row_counter].compact
          # p row
          column = get_values_in_current_column([row_counter, column_counter]).compact
          # p column
          box = get_values_in_current_box([row_counter, column_counter]).compact
          # p box
          existing_values = (row + column + box).uniq
          # p existing_values
          # row.each {|value| remaining.delete(value)}
          # column.each {|value| remaining.delete(value)}
          # box.each {|value| remaining.delete(value)}
          existing_values.each {|value| remaining.delete(value)}
          # p remaining
            if remaining.length == 1
              @puzzle[row_counter][column_counter] = remaining[0]
              #puts self
              row_counter = -1
              column_counter = 0
              break
            else
              column_counter += 1
            end
          # p column_counter
        end
      end
      # column_counter = 0
      row_counter += 1
    end
    puts "Unsolvable with brute logic!" unless self.is_puzzle_solved?
  end

  def get_values_in_current_column(current_coordinate)
    array_with_values_in_column = []
    counter = 0
    while counter < 9
      array_with_values_in_column.push(@puzzle[counter][current_coordinate[1]])
      counter += 1
    end
    array_with_values_in_column
  end

  def get_values_in_current_box(current_coordinate)
    box_values=[]
    @@boxes.each do |box|
      if box.include?(current_coordinate)
        box.each do |coordinate|
          box_values.push(@puzzle[coordinate[0]][coordinate[1]])
        end
      end
    end
    box_values
  end

  def transform_puzzle_string_into_2d_array(board_string)
    array_of_81_strings = board_string.split("")
    array_of_81_ints = array_of_81_strings.map {|str| str.to_i}
    array_of_9_arrays = []
    # array_of_81_ints.each do |element|
    #   row=[]
    #   #9.times row.push(element)

    # end
    9.times do
      row = []
      9.times do
        element = array_of_81_ints.shift
        element = nil if element == 0
        row.push(element)
      end
      array_of_9_arrays.push(row)
    end
    array_of_9_arrays
  end

  def is_puzzle_solved?
    solved_array = (1..9).to_a
    counter = 0
    9.times do
      return false if @puzzle[counter].compact.sort != solved_array
      return false if  get_values_in_current_column([0, counter]).compact.sort != solved_array
      return false if  get_values_in_current_box(@@boxes[counter][0]).compact.sort != solved_array
      counter += 1
    end
    true
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def to_s
    str = ""
    outer_counter = 0

    @puzzle.each do |row|
      inner_counter = 0
      row.each do |element|
        inner_counter += 1
        element = "_" if element == nil
        str << element.to_s
        str << "#" if inner_counter % 3 == 0
      end
      outer_counter += 1
      str << "\n"
      str << "############\n" if outer_counter % 3 == 0
    end
    str.gsub(//,"  ")[0...-39]
  end
end


#one_missing string: "609238745274561398853947621486352179792614583531879264945723816328196457167485932"
# test = Sudoku.new("619238745274561398853947621486352179792614583531879264945723816328196457167480932")
# test = Sudoku.new("030500804504200010008009000790806103000005400050000007800000702000704600610300500")
# p test.puzzle
# puts test
# test.solve!
# puts test
# p test.is_puzzle_solved?
# p test.get_values_in_current_box([4,4])