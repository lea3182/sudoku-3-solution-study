class Sudoku

  attr_reader :board
  def initialize(board_string)
    @board = Array.new(9) { board_string.slice!(0,9).split('') }
    @box = Array.new(9)
  end

  def solve
    3.times do
      @board.each.with_index do |row, row_index|
        row.each.with_index do |cell, column_index|
          if cell == '-'
            poss_num = ('1'..'9').to_a

            poss_num.delete_if { |x| get_row(row_index).include? x }
            poss_num.delete_if { |x| get_column(column_index).include? x }
            poss_num.delete_if { |x| get_box(row_index, column_index).include? x }

            row[column_index] = poss_num[0] if poss_num.length == 1
          end
        end
      end
    end
    # play_result
  end

  # def play_result
  #   board.include? '-' ?  "It's too difficult for me!" : "Good job!"
  # end

  def get_row(index)
    @board[index]
  end

  def get_column(index)
   transpose_board[index]     # ??? can generate a column array without using transpose
  end

  def transpose_board
    @board.transpose
  end

  def get_box(row_index, column_index)
    box_maker
    box_number = 3 * (row_index/3) + (column_index/3)
    @box[box_number]
  end

  def box_maker
    columns = transpose_board
    boxes_zero_three_six = columns[0].zip(columns[1], columns[2])
    boxes_one_four_seven = columns[3].zip(columns[4], columns[5])
    boxes_two_five_eight = columns[6].zip(columns[7], columns[8])
    @box[0] = boxes_zero_three_six.shift(3).flatten
    @box[3] = boxes_zero_three_six.shift(3).flatten
    @box[6] = boxes_zero_three_six.shift(3).flatten
    @box[1] = boxes_one_four_seven.shift(3).flatten
    @box[4] = boxes_one_four_seven.shift(3).flatten
    @box[7] = boxes_one_four_seven.shift(3).flatten
    @box[2] = boxes_two_five_eight.shift(3).flatten
    @box[5] = boxes_two_five_eight.shift(3).flatten
    @box[8] = boxes_two_five_eight.shift(3).flatten
  end

  def board
    @board.flatten.join()
  end

  # Returns a string representing the current state of the board
  def view
    @board.each { |row| puts row.join('') }
  end

  # working on this method
  def to_s
    print_board = ''
    sudoku_board = @board.each { |row| print_board += row.join('') + "\n" }
    print_board
  end

end
