require 'debugger'

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

  # def final_check(index, cell_index, num_to_check)
  #   possible_placements = 0
  #   # here we need to set index = cell_index's square index number
  #   if self.square_check(index, @array[cell_index]) == false
  #     # here we need to set index
  #     if self.row_check(index, @array[cell_index]) == false
  #       if self.column_check(index, @array[cell_index]) == false
  #         if @array[cell_index] == 0
  #           possible_placements += 1
  #         end
  #       end
  #     end
  #   end
  #   if possible_placements == 1
  #     return true
  #   else
  #     return false
  #   end
  # end

  def get_square(cell_index)

    x = (get_row(cell_index)) / 3
    y = (get_column(cell_index)) / 3

    cells_square = y + (x * 3)

    # cells_square = 0 if [0,1,2,9,10,11,18,19,20].include?(cell_index)
    # cells_square = 1 if [3,4,5,12,13,14,21,22,23].include?(cell_index)
    # cells_square = 2 if [6,7,8,15,16,17,24,25,26].include?(cell_index)
    # cells_square = 3 if [27,28,29,36,37,38,45,46,47].include?(cell_index)
    # cells_square = 4 if [30,31,32,39,40,41,48,49,50].include?(cell_index)
    # cells_square = 5 if [33,34,35,42,43,44,51,52,53].include?(cell_index)
    # cells_square = 6 if [54,55,56,63,64,65,72,73,74].include?(cell_index)
    # cells_square = 7 if [57,58,59,66,67,68,75,76,77].include?(cell_index)
    # cells_square = 8 if [60,61,62,69,70,71,78,79,80].include?(cell_index)
    return cells_square
  end

  def get_row(cell_index)
    cells_row = cell_index / 9

    # cells_row = 0 if (0..8).to_a.include?(cell_index)
    # cells_row = 1 if (9..17).to_a.include?(cell_index)
    # cells_row = 2 if (18..26).to_a.include?(cell_index)
    # cells_row = 3 if (27..35).to_a.include?(cell_index)
    # cells_row = 4 if (36..44).to_a.include?(cell_index)
    # cells_row = 5 if (45..53).to_a.include?(cell_index)
    # cells_row = 6 if (54..62).to_a.include?(cell_index)
    # cells_row = 7 if (63..71).to_a.include?(cell_index)
    # cells_row = 8 if (72..80).to_a.include?(cell_index)
    return cells_row
  end

  def get_column(cell_index)

    cells_column = cell_index % 9

    # cells_column = 0 if [0,9,18,27,36,45,54,63,72].include?(cell_index)
    # cells_column = 1 if [1,10,19,28,37,46,55,64,73].include?(cell_index)
    # cells_column = 2 if [2,11,20,29,38,47,56,65,74].include?(cell_index)
    # cells_column = 3 if [3,12,21,30,39,48,57,66,75].include?(cell_index)
    # cells_column = 4 if [4,13,22,31,40,49,58,67,76].include?(cell_index)
    # cells_column = 5 if [5,14,23,32,41,50,59,68,77].include?(cell_index)
    # cells_column = 6 if [6,15,24,33,42,51,60,69,78].include?(cell_index)
    # cells_column = 7 if [7,16,25,34,43,52,61,70,79].include?(cell_index)
    # cells_column = 8 if [8,17,26,35,44,53,62,71,80].include?(cell_index)
    return cells_column
  end

  def final_check(cell_index)
    possible_placements = []
    num_to_check = 1

    # iterate through numbers 1 through 9, checking to see if each number can be placed in the cell_index
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
    #cell_index
    @array[cell_index] = num_to_check

    # @array = @array.map.with_index do |v, i|
    #   if i == cell_index #&& v == 0 #&& self.final_check(index_to_check, cell_index, num_to_check) #&& self.column_check(index_to_check, num_to_check)
    #     v = num_to_check
    #   else
    #     v = v
    #   end
    # end
    # self.square(2)[index_to_check] = num_to_check
  end

  def solve
    # index_to_check = 3 # 0-8
    # cell_index = 16 # 0-80
    # num_to_check = 2
    # self.push_num(index_to_check, cell_index, num_to_check) if self.final_check(index_to_check, num_to_check)
    # # ^ THIS WORKS SORTA ^
    num_to_check = 1
    while @array.include?(0)
      cell_index = 0
      while cell_index <= 80
        @array[cell_index] = final_check(cell_index)
        # self.push_num(cell_index, num_to_check) if self.final_check(cell_index)

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