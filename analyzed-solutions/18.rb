class Sudoku
  def initialize(board_string)
    @board = board_string.scan(/.{9}/)
    @board.map! { |row| row.split("") }.flatten!.map!(&:to_i)
    @board_ref = (0..80).to_a
    @board_ref_str = []

    # map main board indices to rows, columns, and boxes in grid layout
    @rows = [
      (0..8).to_a,
      (9..17).to_a,
      (18..26).to_a,
      (27..35).to_a,
      (36..44).to_a,
      (45..53).to_a,
      (54..62).to_a,
      (63..71).to_a,
      (72..80).to_a
    ]

    @cols = (0..8).map { |n| (0..80).to_a.select { |i| i % 9 == n } }

    @boxes = [
      [0, 1, 2, 9, 10, 11, 18, 19, 20],
      [3, 4, 5, 12, 13, 14, 21, 22, 23],
      [6, 7, 8, 15, 16, 17, 24, 25, 26],
      [27, 28, 29, 36, 37, 38, 45, 46, 47],
      [30, 31, 32, 39, 40, 41, 48, 49, 50],
      [33, 34, 35, 42, 43, 44, 51, 52, 53],
      [54, 55, 56, 63, 64, 65, 72, 73, 74],
      [57, 58, 59, 66, 67, 68, 75, 76, 77],
      [60, 61, 62, 69, 70, 71, 78, 79, 80]
    ]

    @all_rows = []
    @all_cols = []
    @all_boxes = []
  end

  def solve!
    return true if self.solved?
    @board_ref.each do |i|
      if @board[i] == 0
        (1..9).each do |n|
          if !check_board(n, i)
            @board[i] = n
            return true if self.solve!
            @board[i] = 0
          end
        end
        return false
      end
    end
  end

  def check_board(n, index)
    check_rows(n, index) || check_cols(n, index) || check_boxes(n, index)
  end

  def check_rows(n, index)
    row_num = nil
    @rows.each { |row| row_num = @rows.index(row) if row.include?(index) }
    get_board_row(@rows[row_num]).include?(n)
  end

  def get_board_row(indices)
    board_row = indices.map { |i| @board[i] }
    board_row
  end

  def check_cols(n, index)
    col_num = nil
    @cols.each { |col| col_num = @cols.index(col) if col.include?(index) }
    get_board_col(@cols[col_num]).include?(n)
  end

  def get_board_col(indices)
    board_col = indices.map { |i| @board[i] }
    board_col
  end

  def check_boxes(n, index)
    box_num = nil
    @boxes.each { |box| box_num = @boxes.index(box) if box.include?(index) }
    get_board_box(@boxes[box_num]).include?(n)
  end

  def get_board_box(indices)
    board_box = indices.map { |i| @board[i] }
    board_box
  end

  # update variables storing rows, cols, and boxes to reflect current board
  def update
    @all_rows = @board.each_slice(9).to_a

    @all_cols = []
    @cols.each do |col|
      @all_cols << col.map { |i| @board[i] }
    end

    @all_boxes = []
    @boxes.each do |box|
      @all_boxes << box.map { |i| @board[i] }
    end
  end

  def solved?
    update

    # a valid section (row, column, or 3x3 box) contains every number 1-9
    valid = (1..9).to_a

    # check to see if all rows, columns, and boxes are simultaneously valid
    (
      @all_rows.all? { |row| row.sort == valid } &&
      @all_cols.all? { |col| col.sort == valid } &&
      @all_boxes.all? { |box| box.sort == valid }
    )
  end

  def board
    # used as a reference map for board positions
    # @board_ref_str = @board_ref.map { |e| e.to_s.rjust(3, " ") }
    # @board_ref_str.each_slice(9).to_a.each { |row| puts row.join(" ") }
    # puts ""


    # prints out the board
    @board_str = @board.map { |e| e.to_s.rjust(3, " ") }
    output = @board_str.each_slice(9).to_a
    output.map! { |row| row.each_slice(3).to_a }
    output.each_with_index do |row, i|
      row.each_with_index do |section, i|
        print section.join
        print "  |" if i != row.length - 1
      end
      puts ""
      puts "".center(33, "-").rjust(34, " ") if i % 3 == 2 && i != output.length - 1
    end
    puts ""

    update

    # prints out validity of each row, column, and box
    @all_rows.each_with_index do |row, i|
      puts "Row #{i + 1}: #{row.sort} #{row.sort == (1..9).to_a ? 'GOOD' : 'BAD'}"
    end

    puts ""

    @all_cols.each_with_index do |col, i|
      puts "Col #{i + 1}: #{col.sort} #{col.sort == (1..9).to_a ? 'GOOD' : 'BAD'}"
    end

    puts ""

    @all_boxes.each_with_index do |box, i|
      puts "Box #{i + 1}: #{box.sort} #{box.sort == (1..9).to_a ? 'GOOD' : 'BAD'}"
    end

    puts ""
  end
end

# tests
file = File.readlines("set-02_project-euler_50-easy-puzzles.txt")
board_strings = file.map { |board| board.chomp }
total_boards = board_strings.length
boards_solved = 0

# from challenge repo: this board has only 1 missing number
# game = Sudoku.new("609238745274561398853947621486352179792614583531879264945723816328196457167485932")

# example board with solution from challenge repo
game = Sudoku.new("530070000600195000098000060800060003400803001700020006060000280000419005000080079")

puts "STARTING BOARD"
game.board

puts ""

game.solve!

puts "SOLVED BOARD"
game.board

# test all boards in file, tallying total number of boards solved
# board_strings.each_with_index do |board, i|
#   game = Sudoku.new(board)
#
#   puts "STARTING BOARD ##{i + 1}"
#   puts ""
#   game.board
#
#   puts ""
#
#   game.solve!
#
#   if game.solved?
#     boards_solved += 1
#     puts "SOLVED BOARD ##{i + 1}"
#     puts ""
#     game.board
#   end
#
#   puts "Total Boards: #{total_boards}"
#   puts "Boards Solved: #{boards_solved}"
#   puts ""
#   puts ""
# end