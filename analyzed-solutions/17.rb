# Pseudocode
# 1. initialize and break down the string into a multidimensional array
# 2. create solve method - will be largely calling other methods (col, box, row methods, deciding which of them will be appropriate to solve each problem)
# 3. create methods we are going to call in solve method - row, column, box possibilities

class Sudoku
  SECTOR_COORDS = {
    "00" => [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]],
    "01" => [[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]],
    "02" => [[0,6],[0,7],[0,8],[1,6],[1,7],[1,8],[2,6],[2,7],[2,8]],
    "10" => [[3,0],[3,1],[3,2],[4,0],[4,1],[4,2],[5,0],[5,1],[5,2]],
    "11" => [[3,3],[3,4],[3,5],[4,3],[4,4],[4,5],[5,3],[5,4],[5,5]],
    "12" => [[3,6],[3,7],[3,8],[4,6],[4,7],[4,8],[5,6],[5,7],[5,8]],
    "20" => [[6,0],[6,1],[6,2],[7,0],[7,1],[7,2],[8,0],[8,1],[8,2]],
    "21" => [[6,3],[6,4],[6,5],[7,3],[7,4],[7,5],[8,3],[8,4],[8,5]],
    "22" => [[6,6],[6,7],[6,8],[7,6],[7,7],[7,8],[8,6],[8,7],[8,8]]

  }


  def initialize(board_string)
    temp_array = board_string.split('')
    @board = [ ]
    until temp_array.empty? do
      @board << temp_array.shift(9)
    end
    @board.collect! do |row|
      row.collect! do |item|
        item.to_i
      end
    end
  end

  def answer_options
    solution_found = false
    @board.each_with_index do |row, row_index|
      row.each_with_index do |item, col_index|
        if (item == 0) || item.class == Array
          possible_col = possible_from_col(col_index)
          possible_row = possible_from_row(row_index)
          possible_box = possible_from_box(col_index, row_index)
          all_possibles = combined_possibles(possible_col, possible_row, possible_box)
          if all_possibles.length == 1
            @board[row_index][col_index] = all_possibles[0]
            solution_found = true
          else
            @board[row_index][col_index] = all_possibles
          end
        end
      end
    end
    solution_found
  end

  def possible_from_col(col_index)
    results = [ ]
    transposed_board = @board.transpose
    (1..9).each do |number|
      unless transposed_board[col_index].include?(number)
        results << number
      end
    end
    results
  end

  def possible_from_row(row_index)
      results = [ ]
      (1..9).each do |number|
        unless @board[row_index].include?(number)
          results << number
        end
      end
      results
  end

  def possible_from_box(col_index, row_index)
    coords = SECTOR_COORDS["#{(row_index/3)}#{col_index/3}"]
    box_nums = []
    coords.each do |coord|
      box_nums << @board[coord[0]][coord[1]]
    end
    results = [ ]
    (1..9).each do |number|
      unless box_nums.include?(number)
        results << number
      end
    end
    results
  end

  def combined_possibles(array1, array2, array3)
      results = [ ]
      array1.each do |item|
        if array2.include?(item) && array3.include?(item)
          results << item
        end
      end
      results
  end

  def solve!
    while answer_options
      puts "Another Pass"
    end
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    result = ""
    @board.each_with_index do |row, row_index|
      row.each_with_index do |item, index|
        if item.class != Array
          result << "#{item} "
        else
          result << '? '
        end
        if (index + 1) % 3 == 0 && index != 8
          result << '| '
        end
      end
      if (row_index + 1) % 3 == 0
        result << "\n---------------------\n"
      else
        result << "\n"
      end
    end
    result
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('set-01_sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

puts game.board
puts ""
# Remember: this will just fill out what it can and not "guess"
game.solve!

puts game.board