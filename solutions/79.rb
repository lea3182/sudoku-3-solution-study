class Sudoku
  attr_accessor :board_array

  def initialize(board_string)
    @board_string = board_string
    @board_array = []
  end

 def split_board
    @board_string = @board_string.split('')
    @board_string.map!{|x| x.to_i}
    9.times do
       @board_array << @board_string.shift(9)
    end
  end

  def create_possible_values
    @board_array.each do |row|
      row.map! do|cell|
        if cell == 0
           cell = [1,2,3,4,5,6,7,8,9]
        else
           cell
        end
      end
    end
  end

  def search_rows
    @board_array.each do |row|
      row.each do |looking_for_array|
        if looking_for_array.is_a?(Array)
          test_array = looking_for_array
          row.each do |looking_for_integer|
            if looking_for_integer.is_a?(Integer)
              test_array.delete(looking_for_integer)
            end
          end
        end
      end
    end
  end

  def search_columns
    @board_array = @board_array.transpose
    @board_array.each do |row|
      row.each do |looking_for_array|
        if looking_for_array.is_a?(Array)
          test_array = looking_for_array
          row.each do |looking_for_integer|
            if looking_for_integer.is_a?(Integer)
              test_array.delete(looking_for_integer)
            end
          end
        end
      end
    end
    @board_array = @board_array.transpose
  end

  def search_boxes
    @board_array.each_with_index do |row, row_index|
      @board_array[row_index].each_with_index do |cell, column_index|
        if @board_array[row_index][column_index].is_a?(Array)
          @board_array.each_with_index do |inner_row, row_inner_index|
            @board_array[row_inner_index].each_with_index do |inner_cell, column_inner_index|
              if (@board_array[row_inner_index][column_inner_index].is_a?(Integer)) && (row_index / 3) == (row_inner_index / 3) && (column_index / 3) == (column_inner_index / 3)
                  @board_array[row_index][column_index].delete(@board_array[row_inner_index][column_inner_index])
              end
            end
          end
        end
      end
    end
  end

  def flatten
    @board_array.map! do |row|
      row.map! do |cell|
        cell.is_a?(Array) && cell.length == 1 ? cell.first : cell
      end
    end
  end

  def search_rows_columns_boxes_and_flatten
    search_rows
    search_columns
    search_boxes
    flatten
  end

  def board
    @board_array.each do |row|
      print row.join(' ')
      puts ""
    end
  end

  def solve!
    split_board
    create_possible_values
    search_rows_columns_boxes_and_flatten until solved?
    board
  end

  def solved?
    @board_array.flatten.length == 81
  end

end

game = Sudoku.new('619030040270061008000047621486302079000014580031009060005720806320106057160400030')
game.solve!


