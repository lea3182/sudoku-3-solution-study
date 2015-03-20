class Sudoku
  def initialize(board_string)
    @array = []
    board_string.split("").each do |element|
      if (1..9).include?(element.to_i)
        @array << element.to_i
      else
        @array << 0
      end
    end
  end

  def solve
    @array.each_with_index do |cell, index|
      unsolved = (1..9).to_a if cell == 0
      unsolved -= find_row(index) + find_column(index) + find_box(index)
      if unsolved.
    end
  end

  def board

  end

  # Returns a string representing the current state of the board
  def to_s

  end

  # Search Methods

  def find_row(row)
    @row = @array.select.each_index{ |index| index/9 == row } # the idea here is any index in array where index/9 == 0
    return @row
  end

  def find_column(col)
    @column = []
    @array.each_with_index do |value, index|
      @column << value if index % 9 == col
    end
    return @column
  end

  def check_box(boxnum)
    # @boxnum = boxnum
    @box = []
    @array.each_with_index do |value,index|
      box_cords = index.divmod(9).map!{ |x| x/3}
      @box << value if box_cords[0] * 3 + box_cords[1] == boxnum
    end
    @box
  end
    # box_cords = @array.each_index.divmod(9).map!{ |x| x/3}
    # box_cords[0] * 3 + box_cords[1] == boxnum

    # @boxnum= [3*(index/9)] + index %9
    # box_coords = index.divmod(9)
    # box_coords.map!{ |x| x/3}
    # box_coords[0] * 3 + box_coords[1]
  end

end


# Testing the first sudoku challenge

sud_one = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"

game_one = Sudoku.new(sud_one)

p game_one.find_row(0)


