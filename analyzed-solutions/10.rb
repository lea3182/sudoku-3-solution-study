class Sudoku
  attr_reader :board, :box_checker, :column_checker, :solved, :string

  def initialize(string)
    @string = string.split("")
    @board = @string.each_slice(9).to_a
    @board
    @get_columns
    @get_boxes
    @solved == false
  end

  def get_columns
    @column_checker = @board.transpose
    @column_checker
  end

  def get_boxes
    @box_checker = []
    thirds = @string.each_slice(3).to_a

    @box_checker << thirds[0] + thirds[3] + thirds[6]
    @box_checker << thirds[1] + thirds[4] + thirds[7]
    @box_checker << thirds[2] + thirds[5] + thirds[8]
    @box_checker << thirds[9] + thirds[12] + thirds[15]
    @box_checker << thirds[10] + thirds[13] + thirds[16]
    @box_checker << thirds[11] + thirds[14] + thirds [17]
    @box_checker << thirds[18] + thirds[21] + thirds[24]
    @box_checker << thirds[19] + thirds[22] + thirds[25]
    @box_checker << thirds[20] + thirds[23] + thirds[26]

    @box_checker
  end



  def solve
    while @solved == false
      @board.each_with_index do |row, row_index|
      row.each do |cell, cell_index|
      if cell == "-" || cell.is_a?(Array)
        possibilities = ("1".."9").to_a
          (1..9).to_a.each do |num|
          if row.include?(num)
            possibilities.delete(num)
           end
              box_index = 0 if (0..2).include?(row_index) && (0..2).include?(cell_index)
              box_index = 1 if (0..2).include?(row_index) && (3..5).include?(cell_index)
              box_index = 2 if (0..2).include?(row_index) && (6..8).include?(cell_index)
              box_index = 3 if (3..5).include?(row_index) && (0..2).include?(cell_index)
              box_index = 4 if (3..5).include?(row_index) && (3..5).include?(cell_index)
              box_index = 5 if (3..5).include?(row_index) && (6..8).include?(cell_index)
              box_index = 6 if (6..8).include?(row_index) && (0..2).include?(cell_index)
              box_index = 7 if (6..8).include?(row_index) && (3..5).include?(cell_index)
              box_index = 8 if (6..8).include?(row_index) && (6..8).include?(cell_index)
         if @box_checker[box_index].include?(num)
          possibilities.delete(num)
          end

         if @column_checker[cell_index].include?(num)
             possibilities.delete(num)
           end

          if possibilities.length > 1
              @board[row_index][cell_index] == "-"
            else
              @board[row_index][cell_index] = possibilities[0]
            end
          end
        end
      end
    end
      get_columns
      get_boxes
      solved?
    end
    return @board
  end


  def to_s
    @board.each { |row| p row }
  end


  def solved?
    if @string.chars.to_a.include?("-")
       @solved = false
    else
      @solved = true
    end
  end
end

test = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")
test.solve
test.to_s
