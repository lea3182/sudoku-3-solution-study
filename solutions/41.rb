require 'debugger'

class Sudoku
  attr_reader :board

  def initialize(board_string)
    @board = board_string.split('').each_slice(9).to_a
    @solved = false
    draw_cols
    draw_boxes
  end

  def draw_board
    @board.each {|a| p a}
  end

  def draw_cols
    @board_cols = @board.transpose
  end

  def find_box(row, column)
    if row < 3
      return 0 if column < 3
      return 1 if (3..5).include?(column)
      return 2
    elsif (3..5).include?(row)
      return 3 if column < 3
      return 4 if (3..5).include?(column)
      return 5
    else
      return 6 if column < 3
      return 7 if (3..5).include?(column)
      return 8
    end
  end

  def draw_boxes
    @board_boxes = Array.new(9) {Array.new(9)}
    @board.each_with_index do | sub_array, sub_array_index|
      sub_array.each_with_index do |cell, cell_index|
        @board_boxes[find_box(sub_array_index, cell_index)] << @board[sub_array_index][cell_index]
        @board_boxes.map {|a| a.compact!}
      end
    end
  end

  def solved?
    @board.each do |row|
      row.each do |cell|
        return @solved = false if cell.instance_of?(Array)
      end
    end
    return @solved = true
  end

  def row_possibilities_checker_and_setter (given_cell_array, row_index, cell_index)
    array_of_possibilities = []
    @board[row_index].each_with_index do |coord, coord_index|
      if coord.is_a?(Array)
        array_of_possibilities << coord
        array_of_possibilities.delete(coord) if given_cell_array == coord
      end
    end
    array_of_possibilities.flatten!
    reduced_array = given_cell_array - array_of_possibilities
    if reduced_array.size == 1
      return @board[row_index][cell_index] = reduced_array.first
    else
      return given_cell_array
    end
  end

  def col_possibilities_checker_and_setter (col_index)

  end

  def box_possibilities_checker_and_setter (box_index)

  end

  def possibilities_solve
    iterations = 0
    while @solved == false && iterations < 20
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, cell_index|
          if cell.is_a?(Array)
            row_possibilities_checker_and_setter(cell, row_index, cell_index)
            # col_possibilities_checker_and_setter(cell, row_index, cell_index)
            # box_possibilities_checker_and_setter (cell, row_index, cell_index)
          end
        end
      end
      draw_cols
      draw_boxes
      solved?
      iterations += 1
    end
    @board
  end

  def linear_solve
    iterations = 0
    while @solved == false && iterations < 20
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, cell_index|
          if cell == "-" || cell.class == Array
            temp_array = ("1".."9").to_a # if cell == "-"
            # temp_array = @board[row_index][cell_index] if cell.instance_of?(Array)
            (1..9).to_a.each do |num|
              temp_array.delete(num) if row.include?(num)
              temp_array.delete(num) if @board_cols[cell_index].include?(num)
              temp_array.delete(num) if @board_boxes[find_box(row_index,cell_index)].include?(num)
            end
            if temp_array.size == 1
              @board[row_index][cell_index] = temp_array.first
            else
              @board[row_index][cell_index] = temp_array
            end
          end
        end
      end
      draw_cols
      draw_boxes
      # draw_board
      # puts "-" * 60
      solved?
      iterations += 1
    end
  end

  def solve
    @current_board = @board
    iterations = 0
    while @solved == false

      linear_solve
      possibilities_solve
      iterations += 1
      debugger if iterations == 5


    end
    return @board
  end

  def board

  end

  # Returns a string representing the current state of the board
  def to_s
    p @board.join('')
  end
end

start_time = Time.now

# puts "-----------Puzzle 1------------"
# sud_board = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")
# sud_board.draw_board
# puts "-"
# sud_board.solve
# sud_board.draw_board

# puts "-----------Puzzle 2------------"
# sud_board2 = Sudoku.new("--5-3--819-285--6-6----4-5---74-283-34976---5--83--49-15--87--2-9----6---26-495-3")
# sud_board2.solve
# sud_board2.draw_board

# puts "-----------Puzzle 3------------"
# sud_board3 = Sudoku.new("29-5----77-----4----4738-129-2--3-648---5--7-5---672--3-9--4--5----8-7---87--51-9")
# sud_board3.solve
# sud_board3.draw_board

# puts "-----------Puzzle 4------------"
# sud_board4 = Sudoku.new("-8--2-----4-5--32--2-3-9-466---9---4---64-5-1134-5-7--36---4--24-723-6-----7--45-")
# sud_board4.solve
# sud_board4.draw_board

# puts "-----------Puzzle 5------------"
# sud_board5 = Sudoku.new("6-873----2-----46-----6482--8---57-19--618--4-31----8-86-2---39-5----1--1--4562--")
# sud_board5.solve
# sud_board5.draw_board
# sud_board5.to_s

end_time = Time.now

p end_time - start_time
puts "-----------Puzzle 6------------"
sud_board6 = Sudoku.new("---6891--8------2915------84-3----5-2----5----9-24-8-1-847--91-5------6--6-41----")
sud_board6.solve
sud_board6.draw_board

# puts "-----------Puzzle 7------------"
# sud_board7 = Sudoku.new("-3-5--8-45-42---1---8--9---79-8-61-3-----54---5------78-----7-2---7-46--61-3--5--
# ")
# # sud_board.draw_board
# sud_board7.solve
# sud_board7.draw_board

# puts "-----------Puzzle 8------------"
# sud_board8 = Sudoku.new("-96-4---11---6---45-481-39---795--43-3--8----4-5-23-18-1-63--59-59-7-83---359---7")
# sud_board8.solve
# sud_board8.draw_board