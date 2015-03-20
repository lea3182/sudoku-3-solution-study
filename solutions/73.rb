class Sudoku

  def initialize(board_string)
    @board = board_string.split("").each_slice(9).to_a
  end


  def solve!
    return @board if solved?
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        next unless cell == '0'
        current_coordinates = { row: row_index, column: cell_index }
        replace_cell_if_only_answer_at current_coordinates
      end
    end
    solve!
  end


  def solved?
    !@board.flatten.include?('0')
  end


  # private


  def replace_cell_if_only_answer_at coords
    poss = possible_answers_at coords
    @board[coords[:row]][coords[:column]] = poss.first if poss.length == 1
  end


  def possible_answers_at coords
    [*"1".."9"] - (row(coords[:row]) | col(coords[:column]) | box(coords))
  end


  def row row_index
    @board[row_index]
  end


  def col col_index
    @board.transpose[col_index]
  end


  def box coords
    box_coord = coords[:row] / 3 * 3 + coords[:column] / 3
    make_boxes[box_coord]
  end

  def make_boxes
    boxes = Array.new(9) { Array.new }
    @board.flatten.each_with_index do |cell, index|
      box_index = (index / 9 / 3) * 3 + (index % 9 / 3)
      boxes[box_index].push cell
    end
    boxes
  end

  def to_s
    @board.map { |row| row.join(' ') }.join("\n")
  end

end



#################### DRIVER CODE ####################

board_string = File.readlines('sample.unsolved.txt').first.chomp
game = Sudoku.new(board_string)
game.solve!
puts game