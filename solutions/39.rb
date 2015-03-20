class Sudoku

  def initialize(board_string)
    @board = board_string.split("")
  end

  def solve
    return false unless valid_board?
    return @board.join if solved?
    next_empty_cell, possibilities = get_cell_with_lowest_choices
    possibilities.each do |try|
      @board[next_empty_cell] = try
      display_while_running
      solved_board = Sudoku.new(@board.join).solve
      return solved_board if solved_board
    end
    return false
  end

  def valid_board?
    @board.each_with_index do |value, index|
      unless value == "-"
        return false unless (unique_row?(get_row(index)) && unique_col?(get_col(index)) && unique_box?(get_box(index)))
      end
    end
    return true
  end

  def get_cell_with_lowest_choices
    choices_collection = []
    @board.each_with_index do |value, index|
      if value == "-"
        existing = get_row_col_box(index).uniq
        choices = ("1".."9").to_a - existing
        choices_collection << [choices.count, index, choices]
      end
    end
    choices_collection.sort.first[1..2]
  end

  def solved?
    !@board.include?("-")
  end

  def get_row_col_box(index)
    get_row(index) + get_col(index) + get_box(index)
  end

  def get_row(cell_index)
    row_index = (cell_index / 9)
  end

  def get_col(cell_index)
    starting_index = (cell_index % 9)
  end

  def get_box(cell_index)
    row_index = get_row(cell_index)
    col_index = get_row(cell_index)
    row_range = row_start_index..row_start_index+2
    col_range = col_start_index..col_start_index+2
    @board.each_slice(9).to_a[row_range].map { |row| row[col_range] }.flatten
  end

  def unique_row?(row)
    row.delete("-")
    row.uniq.size == row.size
  end

  def unique_col?(col)
    col.delete("-")
    col.uniq.size == col.size
  end

  def unique_box?(box)
    box.delete("-")
    box.uniq.size == box.size
  end

  def board
    @board
  end

  def display_while_running
    print "\e[2J"
    print "\e[H"
    puts self
    # sleep 0.1
  end

  # Returns a string representing the current state of the board
  def to_s
    output = ""
    board = @board.dup
    9.times do
      9.times do
        output << board.shift
        output << " "
      end
      output << "\n"
    end
    output
  end
end
