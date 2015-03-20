class Sudoku
  def initialize(board_string)
    @board = string_to_board(board_string)
    @possibilities = Hash.new { |hash, key| hash[key] = Array.new }
    synthesize_possibilities
  end

  def solve!
    until @possibilities.empty?
      update_board(solved_coordinates)
    end
  end

  def board
    return board_to_string(@board)
  end

  private

  def string_to_board(string)
    board = string.split("").map! { |char| char.to_i }
    board = Array.new(9) { board.shift(9) }
    return board
  end

  def board_to_string(board)
    output = ""

    board.each do |row|
      output << row.join(" ") + "\n"
    end

    return output
  end

  def coordinates
    coordinates = [0,1,2,3,4,5,6,7,8].permutation(2).to_a
    coordinates.concat([0,1,2,3,4,5,6,7,8].zip([0,1,2,3,4,5,6,7,8]))
    coordinates.sort
  end

  def row_summary(coordinate) # coordinate in the format of [row, column]
    row = coordinate.first
    column = coordinate.last

    @board[row].select { |square| square != 0 }
    # returns an array of non-zero numbers
  end

  def column_summary(coordinate) # coordinate in the format of [row, column]
    row = coordinate.first
    column = coordinate.last

    @board.transpose[column].select { |square| square != 0 }
    # returns an array of non-zero numbers
  end

  def synthesize_possibilities
    coordinates.each do |coordinate|
      row = coordinate.first
      column = coordinate.last

      unless @board[row][column] != 0
        set_numbers = row_summary(coordinate) + column_summary(coordinate)
        @possibilities[coordinate] = (1..9).reject { |x| set_numbers.include?(x) }
      end
    end
  end

  def print_possibilities
    @possibilities.each do |coordinate, possibilities|
      puts "possibilities for coordinate #{coordinate}: #{possibilities.join(" ")}"
    end
  end

  def solved_coordinates
    single_values = @possibilities.select { |coordinate, possibilities| possibilities.length == 1 }
    return single_values.keys
  end

  def update_board(solved_coordinates)
    solved_coordinates.each do |solved_coordinate|
      row = solved_coordinate.first
      column = solved_coordinate.last

      @board[row][column] = @possibilities[solved_coordinate][0]
      @possibilities.delete(solved_coordinate)
      synthesize_possibilities
    end
  end

end

board_string = File.readlines('sample.unsolved.txt')[0].chomp
game = Sudoku.new(board_string)

puts "ORIGINAL BOARD"
puts game.board

game.solve!
puts
puts "SOLVED BOARD"
puts game.board