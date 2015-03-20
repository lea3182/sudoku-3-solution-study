class Sudoku
  def initialize(board_string)
    @board = board_string.split('').map! {|x| x.to_i}
  end

  def get_row(cell_index)
    @board[(cell_index / 9) * 9,9] - [0]
  end

  def get_column(cell_index)
    column_index = cell_index % 9
    column_array = []
    9.times do |i|
      column_array << @board[column_index + i * 9]
    end
    column_array - [0]
  end

  def get_box( cell_index)
    boxes = {
      0 => [0,1,2,9,10,11,18,19,20],
      1 => [3,4,5,12,13,14,21,22,23],
      2 => [6,7,8,15,16,17,24,25,26],
      3 => [27,28,29,36,37,38,45,46,47],
      4 => [30,31,32,39,40,41,48,49,50],
      5 => [33,34,35,42,43,44,51,52,53],
      6 => [54,55,56,63,64,65,72,73,74],
      7 => [57,58,59,66,67,68,75,76,77],
      8 => [60,61,62, 69,70,71,78,79,80]
    }
    @box = []
    boxes.each do |key, value|
      @value = value if value.include?(cell_index)
    end
    @value.each { |cell| @box << @board[cell]}
    @box - [0]
  end

  def possible_solutions(cell_index)
    sample_array = (1..9).to_a
    return sample_array - get_row(cell_index) - get_column(cell_index) - get_box(cell_index)
  end

  def solve_cell(cell_index, n = 0)
    @board[cell_index] = possible_solutions(cell_index)[n]
  end

  def solved?
    @board.count(0) == 0
  end

  def logic_solve
    stuck = false
    until stuck == true
      stuck = true
      @board.each_with_index do |cell, cell_index|
        if @board[cell_index] == 0
          if possible_solutions(cell_index).length == 1
            solve_cell(cell_index)
            stuck = false
          end
        end
      end
    end
    return @board
  end

  def no_repeats?(cell)
    get_row(cell).uniq == get_row(cell) && get_box(cell).uniq == get_box(cell) && get_column(cell).uniq == get_column(cell)
  end

  def solve!(logic_board = logic_solve)
    next_empty_cell = @board.index(0)
    return @board if solved?
    return false if !(no_repeats?(next_empty_cell))
    possible_solutions(next_empty_cell).each do |possibility|
      @board[next_empty_cell] = possibility
      solving_board = Sudoku.new(@board.join('')).solve!
      return solving_board if solving_board
    end
    return false
  end
end