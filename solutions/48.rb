require 'colored'
class Sudoku
  attr_accessor :board_string, :box_hash

  def initialize(board_string)
    @board_string = board_string
    @box_hash = {
      "00" => [],
      "01" => [],
      "02" => [],
      "10" => [],
      "11" => [],
      "12" => [],
      "20" => [],
      "21" => [],
      "22" => []
    }
    @board_string.split('').each_with_index do |value,location|
      row = location / 9
      col = location % 9
      box_key = (row/3).to_s + (col/3).to_s
      @box_hash[box_key].push(location)
    end
  end

  def solve!
    while board_string.include?('0')
      [*0...81].each {|ind| solve_cell(ind) if board_string[ind] == "0" }
    end
  end

  def solve_cell(location)
    not_poss = row(location) | col(location) | box(location)
    poss = [*"1".."9"] - not_poss.reject{|val| val == 0 }
      if poss.length == 1
        board_string[location] = poss[0]
      end
  end

  def row(location)
    row = location / 9
    rows = [*0...81].keep_if {|ind| ind / 9 ==row}
    .map { |ind| board_string[ind] }
  end

  def col(location)
    col = location % 9
    cols = [*0...81].keep_if {|ind| ind % 9 == col}
    .map { |ind| board_string[ind] }
  end

  def box(location)
    row = location / 9
    col = location % 9
    box_key = (row/3).to_s + (col/3).to_s
    boxes = box_hash[box_key].map { |ind| board_string[ind] }
    #p boxes
  end

  def board
    puts "__________________________________".blue
    board_string.split("").each_slice(9) {|row| puts row.join(' | ').gsub("0",' ') }
    puts "----------------------------------".blue
  end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them
puts "First Game"

board_string = File.readlines('sample.unsolved.txt').first.chomp
game = Sudoku.new(board_string)
puts game.board
game.solve!
puts game.board

puts "Second Game"

game = Sudoku.new('619030040270061008000047621486302079000014580031009060005720806320106057160400030')
puts game.board
game.solve!
puts game.board


