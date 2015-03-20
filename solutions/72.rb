class Sudoku
  attr_accessor :board_string
  def initialize(board_string)
    @board_string = board_string.split("")
  end

  def check_row(index)
    @board_string[index/9]
  end

  def check_col(index)
    @board_string[index%9]
  end

  def check_box(index)

    box_0 = [0, 1, 2, 9, 10, 11, 18, 19, 20]
    box_1 = [3, 4, 5, 12, 13, 14, 21, 22, 23]
    box_2 = [6, 7, 8, 15, 16, 17, 24, 25, 26]
    box_3 = [27, 28, 29, 36, 37, 38, 45, 46, 47]
    box_4 = [30, 31, 32, 39, 40, 41, 48, 49, 50]
    box_5 = [33, 34, 35, 42, 43, 44, 51, 52, 53]
    box_6 = [54, 55, 56, 63, 64, 65, 72, 73, 74]
    box_7 = [57, 58, 59, 66, 67, 68, 75, 76, 77]
    box_8 = [60, 61, 62, 69, 70, 71, 78, 79, 80]

    case
    when box_0.include?(index)
      box_0
    when box_1.include?(index)
      box_1
    when box_2.include?(index)
      box_2
    when box_3.include?(index)
      box_3
    when box_4.include?(index)
      box_4
    when box_5.include?(index)
      box_5
    when box_6.include?(index)
      box_6
    when box_7.include?(index)
      box_7
    when box_8.include?(index)
      box_8
    else
      "no box error"
    end
  end

  def find_candidates(index) # compare arrays of possibles
    row_array = []
    col_array = []
    box_array = []

    control_array = [*1..9].map { |n| n.to_s}

    # @board_string.each_with_index do |item, i|
    #   col_array << item if check_col(index) == i%9
    #   row_array << item if check_row(index) == i/9
    #   box_array << item if check_box(index).include?(i)
    # end

    check_box(index)

    # candidates = control_array - (row_array + col_array + board_string).flatten

    # if candidates.length == 1
    #    return candidates.join
    # else
    #   return "0"
    # end

  end


  def solve!
    #while @board_string.include?("0")
      @board_string.map!.each_with_index do |item, index|
        if item == "0"
          p find_candidates(index)
        else item
        end
      end
    #end

    p @board_string

  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  #def board

  #end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
#board_string = File.readlines('sample.unsolved.txt').first.chomp
board_string = "105802000090076405200400819019007306762083090000061050007600030430020501600308900"

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

#puts game.board