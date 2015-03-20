class Sudoku
  attr_reader :array
  def initialize(board_string)
    @array = []
    board_string.split("").each do |element|
      if (1..9).include?(element.to_i)
        @array << element.to_i
      else
        @array << 0
      end
    end
    solve
  end

  def row(index)
    @array.each_slice(9).to_a[index]
  end

  def column(index)
    column = []
    range = [0, 9, 18, 27, 36, 45, 54, 63, 72].map { |n| n += index }
    @array.each_with_index do |v, i|
      column << v if range.include?(i)
    end
    column
  end

  def square(index)
    square = []
    range = [0, 3, 6, 27, 30, 33, 54, 57, 60]
    range_index = range[index]
    3.times do
      square << @array[range_index]
      square << @array[range_index + 1]
      square << @array[range_index + 2]
      range_index += 9
    end
    square
  end

  def row_check(index, num) # Does n row contain num? where index points to n row
    self.row(index).include?(num) ? true : false
  end

  def column_check(index, num) # Does n column contain num? where index points to n column
    self.column(index).include?(num) ? true : false
  end

  def square_check(index, num) # Does n square contain num? where index points to n square
    test = (0..10).to_a
    if self.square(index).include?(num)
      return true
    else
      return false
    end
  end

  def get_square(cell_index)
    x = (get_row(cell_index)) / 3
    y = (get_column(cell_index)) / 3
    cells_square = y + (x * 3)
  end

  def get_row(cell_index)
    cells_row = cell_index / 9
  end

  def get_column(cell_index)
    cells_column = cell_index % 9
  end

  def final_check(cell_index)
    possible_placements = []
    num_to_check = 1
    while num_to_check < 10
      index = get_square(cell_index) # here we need to set index = cell_index's square index number
      if self.square_check(index, num_to_check) == false
        index = get_row(cell_index) # here we need to set index = cell_index's row index number
        if self.row_check(index, num_to_check) == false
          index = get_column(cell_index) # here we need to set index = cell_index's column index number
          if self.column_check(index, num_to_check) == false
            if @array[cell_index] == 0
              possible_placements << num_to_check
            end
          end
        end
      end
    num_to_check += 1
    end

    # If only a single number can be placed, return true
    if possible_placements.length == 1
      return possible_placements[0]
    else
      return @array[cell_index]
    end
  end

  def push_num(cell_index, num_to_check)
    @array[cell_index] = num_to_check
  end

  def solve
    num_to_check = 1
    while @array.include?(0)
      cell_index = 0
      while cell_index <= 80
        @array[cell_index] = final_check(cell_index)
        cell_index += 1
      end
      num_to_check += 1
    index_to_check = 3 # 0-8
      num_to_check = 1 if num_to_check > 9
      puts
    end
  end

  # Returns string in original pure text form (with dashes)
  def board
    string = ""
    @array.each do |element|
      if (1..9).include?(element)
        string << element.to_s
      else
        string << "-"
      end
    end
    string
  end

  # Returns a (human-readable) string representing the current state of the board
  def to_s
    board_str = ""
    square_index = 0
    new_line_counter = 1
    @array.each_with_index do |v, i|
      board_str << v.to_s #if (0..2).include?(i)
      if new_line_counter % 9 == 0
        board_str << "\n"
      elsif new_line_counter % 3 == 0
        board_str << " "
      else
        board_str << " "
      end
      new_line_counter += 1
    end
    if @array.include?(0) == true
      board_str
    else
      self.fancy_display
    end
  end

  def fancy_display
    print "▲▼▲ SUDOKU ▲▼▲\n"
        board_str = ""
    square_index = 0
    new_line_counter = 1
    @array.each_with_index do |v, i|
      board_str << v.to_s
      if new_line_counter % 9 == 0
        board_str << "\n"
      elsif new_line_counter % 3 == 0
        board_str << " | "
      else
        board_str << "|"
      end
      new_line_counter += 1
    end
    print board_str
    print "▼▲▼ SOLVED! ▼▲▼\n\n"
  end
end
