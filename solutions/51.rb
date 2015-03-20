class Sudoku
  attr_reader :board, :rows, :columns, :boxes

  def initialize(board_string)
    @board = board_string.split("")
    @rand_nums = (1..9).to_a.shuffle #optimizing....runs .04s faster :)
    prepare_board
  end

  def invalid?
    for n in (0..8)
      return true if dup?(@rows[n])
      return true if dup?(@boxes[n])
      return true if dup?(@columns[n])
    end
    return false
  end

  def dup?(subset)
    subset = subset.reject { |x| x == "-" }
    subset.uniq.length == subset.length ? false : true
  end

  def solved?
    if @board.count("-") == 0
      puts
      puts "Winning combo:"
      p @board.join
      puts
      return true
    else
      return false
    end
  end

  def prepare_board
    @rows = Array.new(9) {Array.new()}
    @columns = Array.new(9) {Array.new()}
    @boxes = Array.new(9) {Array.new()}

    @board.each_with_index do |value, index|
      @rows[row_pos?(index)].push(value)
      @columns[column_pos?(index)].push(value)
      @boxes[box_pos?(index)].push(value)
    end
  end

  def row_pos?(position)
    position / 9
  end

  def column_pos?(position)
    position % 9
  end

  def box_pos?(position)
    return 0 if row_pos?(position) / 3 == 0 && column_pos?(position) / 3 == 0
    return 1 if row_pos?(position) / 3 == 0 && column_pos?(position) / 3 == 1
    return 2 if row_pos?(position) / 3 == 0 && column_pos?(position) / 3 == 2
    return 3 if row_pos?(position) / 3 == 1 && column_pos?(position) / 3 == 0
    return 4 if row_pos?(position) / 3 == 1 && column_pos?(position) / 3 == 1
    return 5 if row_pos?(position) / 3 == 1 && column_pos?(position) / 3 == 2
    return 6 if row_pos?(position) / 3 == 2 && column_pos?(position) / 3 == 0
    return 7 if row_pos?(position) / 3 == 2 && column_pos?(position) / 3 == 1
    return 8 if row_pos?(position) / 3 == 2 && column_pos?(position) / 3 == 2
  end

  def solve!
    return false if invalid?
    return true if solved?

    next_spot = @board.index("-")


    @rand_nums.each do |num|
    # (1..9).each do |num|
      @board[next_spot] = num.to_s
      Sudoku.new(@board.join).solve!
    end
  end
end

board_string = File.readlines('sudoku_puzzles.txt').first.chomp

x = Time.now
game = Sudoku.new(board_string).solve!
print "Completion time: "
puts Time.now - x