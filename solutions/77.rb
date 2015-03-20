class Sudoku

  attr_accessor :board_numbers, :board_h
  NUMBERS = (1..9).to_a

  def initialize(board_numbers)
    @board_numbers = board_numbers.split("").inject([]) {|ary, c| ary << c.to_i}
    @board_h = add_box_num(to_hash(@board_numbers))
  end

  def check_col(coords)
    col_array = []
    @board_h.select { |k,v| col_array << v[0] if k[0] == coords[0] }
    col_array.delete(0)
    col_array
  end

  def check_row(coords)
    row_array = []
    @board_h.select { |k,v| row_array << v[0] if k[1] == coords[1] }
    row_array.delete(0)
    row_array
  end

  def check_box(coords)
    box_array = []
    @board_h.select { |k,v| box_array << v[0] if k[2] == coords[2] }
    box_array.delete(0)
    box_array
  end

  def track_counts(coords)
    col = check_col(coords)
    row = check_row(coords)
    box = check_box(coords)
    board_h[coords][1] = col.length
    board_h[coords][2] = row.length
    board_h[coords][3] = box.length
  end

  def find_common
    board_numbers = board_h.values.select {|v| v[0]==0}
    return board_h if board_numbers == []
    board_h.each do |cell|
      track_counts(cell[0])
    end
    unsolved_cells = board_h.select {|_,v| v[0]==0}
    ordered_cells = unsolved_cells.sort_by {|k,v| v[-3..-1]}

    ordered_cells.each do |coords|
      missing_ary_col = NUMBERS - check_col(coords[0])
      missing_ary_row = NUMBERS - check_row(coords[0])
      missing_ary_box = NUMBERS - check_box(coords[0])
      common = missing_ary_box & missing_ary_col & missing_ary_row

      if common.count == 1
        board_h[coords[0]][0] = common.pop
      else
        # magic
      end
    end
    find_common
  end

  def answer_int
    answer_int = []
    board_h.each {|_,numbers| answer_int << numbers[0] }
    answer_int
  end

  def solve!
    find_common
  end

  def board
    answer = answer_int
    board = Array.new(9) { answer.shift(9) }
    board.map{|row| row.join(" ") + "\n"}.join
  end

  private

  def to_hash(board_numbers)
    coords = []
    board_numbers.each_with_index { |n, i| coords << [[i%9, i/9], [n]] }
    @board_h = Hash[coords]
  end

  def add_box_num(board)
    board.select{|k,_| k[0].between?(0,2) && k[1].between?(0,2) }.map {|k,_| k << 0} # box 0
    board.select{|k,_| k[0].between?(3,5) && k[1].between?(0,2) }.map {|k,_| k << 1} # box 1
    board.select{|k,_| k[0].between?(6,8) && k[1].between?(0,2) }.map {|k,_| k << 2} # box 2
    board.select{|k,_| k[0].between?(0,2) && k[1].between?(3,5) }.map {|k,_| k << 3} # box 3
    board.select{|k,_| k[0].between?(3,5) && k[1].between?(3,5) }.map {|k,_| k << 4} # box 4
    board.select{|k,_| k[0].between?(6,8) && k[1].between?(3,5) }.map {|k,_| k << 5} # box 5
    board.select{|k,_| k[0].between?(0,2) && k[1].between?(6,8) }.map {|k,_| k << 6} # box 6
    board.select{|k,_| k[0].between?(3,5) && k[1].between?(6,8) }.map {|k,_| k << 7} # box 7
    board.select{|k,_| k[0].between?(6,8) && k[1].between?(6,8) }.map {|k,_| k << 8} # box 8
    board.rehash
  end

end

board_numbers = "105802000090076405200400819019007306762083090000061050007600030430020501600308900"
game = Sudoku.new(board_numbers)
game.solve!

puts game.board