class Sudoku

  def initialize(board_string)
    @board = Array.new(9) {board_string.slice!(0,9).split('')}
    @boxes = Array.new(9)
  end

  def transpose_board
    @board.transpose
  end

  def solve
    10.times do
      check_all_cells
    end
  end

  def each_cell_in_row(row, row_index)
    row.each.with_index do |cell, cell_index|
       check_cell(row, row_index, cell, cell_index)
    end #ends cell checker
  end

  def check_all_cells
    @board.each.with_index do |row, row_index|
      each_cell_in_row(row, row_index)
    end #row checker end
  end #closes method

  def check_cell(row, row_index, cell, cell_index)
    if cell == "-"
      possible_numbers = generate_possible_numbers

      narrow_down_possible_numbers(row, row_index, cell_index, possible_numbers)

      fill_in_cell_if_possible(row_index, cell_index, possible_numbers)
    end
  end

  def narrow_down_possible_numbers(row, row_index, cell_index, possible_numbers)
    delete_from_a_if_match_in_b(possible_numbers, row)

    column = get_column(cell_index)
    delete_from_a_if_match_in_b(possible_numbers, column)

    box = get_box(row_index, cell_index)
    delete_from_a_if_match_in_b(possible_numbers, box)
  end

  def cell_is_empty?(cell)
    cell == ""
  end

  def fill_in_cell_if_possible(row_index, cell_index, possible_numbers)
    if possible_numbers.length == 1
      @board[row_index][cell_index] = possible_numbers[0]
    end
  end

  def get_row(row_index)
    @board[row_index]
  end

  def get_column(cell_index)
    transpose_board[cell_index]
  end

  def get_cell(row_index, cell_index)
    @board[row_index][cell_index]
  end

  def generate_possible_numbers
    ('1'..'9').to_a
  end

  def delete_from_a_if_match_in_b(a,b)
    a.delete_if { |x| b.include? x}
  end

  def board
    @board.flatten.join()
  end

  # Returns a string representing the current state of the board
  def to_s #gives us pretty ouput
    @board.collect {|row| row.join("")}.join("\n")
  end

  def reset_boxes
    @boxes = []
  end

  def make_boxes
    reset_boxes

    boxes_row0 = zip_rows_into_rows_of_boxes(0,1,2)
    boxes_row1 = zip_rows_into_rows_of_boxes(3,4,5)
    boxes_row2 = zip_rows_into_rows_of_boxes(6,7,8)

    push_box_rows_to_array_of_boxes(boxes_row0, boxes_row1, boxes_row2)
  end

  def push_box_rows_to_array_of_boxes(zeroth_row, first_row, second_row)
    populate_boxes_array_with(zeroth_row)
    populate_boxes_array_with(first_row)
    populate_boxes_array_with(second_row)
  end

  def zip_rows_into_rows_of_boxes(row, second_row, third_row)
    @board[row].zip(@board[second_row],@board[third_row])
  end

  def populate_boxes_array_with(box_row_array)
    box_row_array.each_slice(3) {|sub_array| @boxes << sub_array.flatten}
  end

  def get_box(row_index, column_index)
    make_boxes
    box_number = calculate_box_number(row_index, column_index)
    @boxes[box_number]
  end

  def calculate_box_number(row_index, column_index)
    box_number = 3 * (row_index/3) + (column_index/3)
  end

end