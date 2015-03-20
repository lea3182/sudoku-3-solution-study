require 'debugger'

class Sudoku

  def initialize(input_string)
    @board = {}
    @solved = {}
    create_board(input_string)
  end

  def create_board(input)
    hash = {}
    input.split("").each_with_index do |char, index|
      char == '-' ? @board[index] = (1..9).to_a : @solved[index] = char.to_i
    end
  end

  def check_board
    @solved.length == 81 ? solved? : change_board
  end

  def solved?
    @solved.length == 81? display_board : false
  end

  def display_board
    display_array = []
    @solved.sort.map{|a| display_array << a[1]}
    puts display_array.join
  end

  def change_board
    @board.each do |key, value|
      if @board[key].length == 1
        @board.delete(key)
        @solved[key] = value.join.to_i
      end
    end
    solve
  end

  def find_row(cell)
    cell / 9
  end

  def find_column(cell)
    cell % 9
  end

  def check_column(current, test, answer)
    if find_column(current) == find_column(test)
      @board[current].delete(answer)
    end
  end

  def check_row(current, test, answer)
    if find_row(current) == find_row(test)
      @board[current].delete(answer)
    end
  end

  def check_box(current, test, answer)
    if find_box(current) == find_box(test)
      @board[current].delete(answer)
    end
  end

  def find_box(cell)
    coords = []
    coords << find_row(cell)/3
    coords << find_column(cell)/3
    return coords
  end

  def solve
    @board.each do |coord, possibility|
      @solved.each do |key, answer|
        check_row(coord, key, answer)
        check_column(coord, key, answer)
        check_box(coord, key, answer)
      end
    end
    check_board
  end

end



sudoku = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")
sudoku.solve