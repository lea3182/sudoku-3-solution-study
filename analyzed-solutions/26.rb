# Input: String of numbers of length 81
# Output: String of completed numbers of length 81
# Store the board within a 2d array

# determine_box(box)
  # Returns a list of the coordinates comprising a box

# gather_blank_spaces(box)
  # Returns a list of the coordinates of every blank space in the box

# gather_unused_numbers(box)
  # Returns a list of numbers that haven't been used in the given box

# check_row(row, number)
  # Returns whether the given number has been used yet in the given row

# check_col(col, number)
  # Returns whether the given number has been used yet in the given col

# While there is still a blank space on the board...
  # For each box on the board...
    # Run "unused_numbers_in_box"
    # Run "gather_blank_spaces"
      # For each blank space in box...
        # Reduce list of options returned by "unused_numbers_in_box" by
        # running "check_row" and "check_col" on each number, and the corresponding
        # row/col
    # Cross references the lists of options for each blank space, and
    # eliminate similar numbers
    # If there is a blank space with an option remaining after elimination...
      # Insert number in the given space

# For each blank space in a box, collect a list of viable numbers
# Cross reference each list, and eliminate the similar numbers
# If there is a blank space with a number remaining after elimination, insert that number
require 'debugger'
require 'pp'
class Sudoku
  attr_accessor :array
  def initialize(board_string)
    @board = Array.new()
    @board_string = board_string
    @board_string.split("").each_slice(9) { |row| @board << row}
  end

  def determine_box(row, col)
  # Returns a list of the coordinates comprising a box
    if row >= 0 && row <= 2 && col >= 0 && col <= 2 # top left
      return [[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]]
    elsif row >= 0 && row <= 2 && col >= 3 && col <= 5 # top middle
      return [[0, 3], [0, 4], [0, 5], [1, 3], [1, 4], [1, 5], [2, 3], [2, 4], [2, 5]]
    elsif row >= 0 && row <= 2 && col >= 6 && col <= 8 # top right
      return [[0, 6], [0, 7], [0, 8], [1, 6], [1, 7], [1, 8], [2, 6], [2, 7], [2, 8]]
    elsif row >= 3 && row <= 5 && col >= 0 && col <= 2 # middle left
      return [[3, 0], [3, 1], [3, 2], [4, 0], [4, 1], [4, 2], [5, 0], [5, 1], [5, 2]]
    elsif row >= 3 && row <= 5 && col >= 3 && col <= 5 # middle middle
      return [[3, 3], [3, 4], [3, 5], [4, 3], [4, 4], [4, 5], [5, 3], [5, 4], [5, 5]]
    elsif row >= 3 && row <= 5 && col >= 6 && col <= 8 # middle right
      return [[3, 6], [3, 7], [3, 8], [4, 6], [4, 7], [4, 8], [5, 6], [5, 7], [5, 8]]
    elsif row >= 6 && row <= 8 && col >= 0 && col <= 2 # bottom left
      return [[6, 0], [6, 1], [6, 2], [7, 0], [7, 1], [7, 2], [8, 0], [8, 1], [8, 2]]
    elsif row >= 6 && row <= 8 && col >= 3 && col <= 5 # bottom middle
      return [[6, 3], [6, 4], [6, 5], [7, 3], [7, 4], [7, 5], [8, 3], [8, 4], [8, 5]]
    elsif row >= 6 && row <= 8 && col >= 6 && col <= 8 # bottom right
      return [[6, 6], [6, 7], [6, 8], [7, 6], [7, 7], [7, 8], [8, 6], [8, 7], [8, 8]]
    end
  end

  def gather_blank_spaces(box)
  # Returns a list of the coordinates of every blank space in the box
    blank_spaces = []
    box.each_with_index do |coords, index|
      blank_spaces << coords if @board[coords.first][coords.last] == "0"
    end
    blank_spaces
  end

  def gather_unused_numbers(box)
  # Returns a list of numbers that haven't been used in the given box
    used_numbers = []
    box.each do |coords|
      used_numbers << @board[coords.first][coords.last] unless @board[coords.first][coords.last] == "0"
    end
    unused_numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    used_numbers.each { |num| unused_numbers.delete(num)}
    unused_numbers
  end

  def check_row(row, num)
  # Returns whether the given number has been used yet in the given row
    @board[row].each do |current|
      return true if current == num
    end
    return false
  end

  def check_col(col, num)
  # Returns whether the given number has been used yet in the given column
    @board.transpose[col].each do |current|
      return true if current == num
    end
    return false
  end

  def blank_spaces_remaining?
    @board.each do |row|
      row.each do |num|
        return true if num == "0"
      end
    end
    return false
  end

  def solve!
    while blank_spaces_remaining?
      # Array.new(9).each_with_index do |row, y|
      #   row.each_with_index do |num, x|
      for row in 0..8 do
        for col in 0..8 do
          box = determine_box(row, col)
          possibilities = possibilities(box)
          possibilities_hash = elimination(possibilities)
          insert(possibilities_hash)
          # insert(elimination(possibilities(determine_box(y, x))), y, x)
        end
      end
    end
  end

  def possibilities(box)
  # Returns a hash of blank space coordinates with corresponding possible numbers
    possibilities_hash = {}
    gather_blank_spaces(box).each do |coords|
      possibilities = gather_unused_numbers(box)
      possibilities.each do |num|
        possibilities.delete(num) if check_row(coords.first, num) || check_col(coords.last, num)
      end
      possibilities_hash[coords] = possibilities
    end
    possibilities_hash
  end

  def elimination(possibilities_hash)
  # Returns a modified possibilities hash, after cross referencing and deleting
  # reoccuring numbers
    duplicates = []
    storage = []
    possibilities_hash.each_value {|value| value.each {|x| duplicates << x}}
    duplicates.each {|num| storage << num unless storage.include?(num)}
    storage.each {|num| duplicates.delete_at(duplicates.find_index(num))}
    duplicates.uniq!

    possibilities_hash.each_pair do |key, value|
      duplicates.each do |num|
        value.delete(num)
      end
    end
    possibilities_hash
  end

  def insert(possibilities_hash)
  # Inserts a number into a blank space, if given possibilities hash
  # indicates that it is a sure fit
    possibilities_hash.each_pair do |key, value|
      if value.length == 1
        puts "Inserting value"
        @board[key.first][key.last] = value.first
      end
    end
  end

  def board_to_string
    string = ""
    @board.each_with_index do |row, y|
      row.each_with_index do |num, x|
        string += num
      end
    end
    string
  end

  def to_s
    output = ""
    @board.each do |row|
      row.each {|num| output += num + " "}
      output += "\n"
    end
    output
  end
end

# # The file has newlines at the end of each line, so we call
# # String#chomp to remove them.
# board_string = File.readlines('sample.unsolved.txt').first.chomp

# game = Sudoku.new(board_string)

# # Remember: this will just fill out what it can and not "guess"
# game.solve!

# puts game.board


# p game.check_row(0, "7") # false
# p game.check_col(0, "8") # false
# p game.check_row(1, "9") # true
# p game.check_col(1, "6") # true

game = Sudoku.new("000000907000420180000705026100904000050000040000507009920108000034059000507000000")
puts game
game.solve!
puts
puts game

# p game.blank_spaces_remaining?
# finished = Sudoku.new(string.gsub(/0/, "1"))
# p finished.blank_spaces_remaining?

# string = "534678912672195348198342567895761423426853791713924856961537284287419635345286079"
# new_game = Sudoku.new(string.gsub(/5/, "0"))
# puts new_game
# new_game.solve!
# puts
# puts new_game