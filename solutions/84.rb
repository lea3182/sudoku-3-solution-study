class Sudoku
  attr_reader :nested_board
  def initialize(board_string)
    @cell_array = []
    @board_array = board_string.split('').map! {|letter| letter.to_i}
    @board_array.each_with_index do |cell_int, index|
      @cell_array << Cell.new(cell_int,index)
    end
    @area_hash = Hash.new { |hash, key| hash[key] = Array.new }
    box_sort
  end

  def solve!
    @cell_array.select {|cell| cell.empty?}.each do |cell|
      reduce_possibilities(cell)
      if cell.potentials.length == 1
        @nested_board[cell.row][cell.column] = cell.potentials[0]
        solve!
      end
    end
  end

  def reduce_possibilities(cell)
    cell.potentials -= @nested_board[cell.row]
    cell.potentials -= @nested_board.transpose[cell.column]
    cell.potentials -= @area_hash[cell.boxname]
  end

  def box_sort
   @cell_array.each do |cell|
    case cell.boxname
      when "NW" then @area_hash[cell.boxname] << cell.val
      when "N" then @area_hash[cell.boxname] << cell.val
      when "NE" then @area_hash[cell.boxname] << cell.val
      when "W" then @area_hash[cell.boxname] << cell.val
      when "C" then @area_hash[cell.boxname] << cell.val
      when "E" then @area_hash[cell.boxname] << cell.val
      when "SW" then @area_hash[cell.boxname] << cell.val
      when "S" then @area_hash[cell.boxname] << cell.val
      when "SE" then @area_hash[cell.boxname] << cell.val
    end
   end
  end

  def string_split
   @nested_board = @board_array.each_slice(9).map{|a| a}
  end

  def print_board
   @nested_board.each {|row| puts " #{row}"}
   print "\n"
  end
end


class Cell
  attr_accessor :val, :row, :column, :potentials, :boxname

  def initialize(int, index)    # index is between 0 and 80
   @val = int.to_i
   @row = index/9
   @column = index%9
   @box = [@row/3,@column/3]
    if    @row.between?(0,2)              # northern boxes
     @boxname = "NW" if @column.between?(0,2) # northwest
     @boxname = "N"  if @column.between?(3,5) # north
     @boxname = "NE" if @column.between?(6,8) # northeast
    elsif @row.between?(3,5)              # central boxes
     @boxname = "W"  if @column.between?(0,2) # west
     @boxname = "C"  if @column.between?(3,5) # center
     @boxname = "E"  if @column.between?(6,8) # east
    elsif @row.between?(6,8)              # southern boxes
     @boxname = "SW" if @column.between?(0,2) # southwest
     @boxname = "S"  if @column.between?(3,5) # south
     @boxname = "SE" if @column.between?(6,8) # southeast
    else
     puts "how to get rid of this else line?"
    end
   @potentials = (1..9).to_a - [@val]
   #puts "val is #{@val}   row is #{@row}   col is #{@column}   @box is #{@box} #{@boxname} potentials #{@potentials}"
  end

  def empty?
    @val == 0
  end
end


# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)
game.string_split
game.print_board
# Remember: this will just fill out what it can and not "guess"
game.solve!
game.print_board

p game.nested_board == [[1, 4, 5, 8, 9, 2, 6, 7, 3], [8, 9, 3, 1, 7, 6, 4, 2, 5], [2, 7, 6, 4, 3, 5, 8, 1, 9], [5, 1, 9, 2, 4, 7, 3, 8, 6], [7, 6, 2, 5, 8, 3, 1, 9, 4], [3, 8, 4, 9, 6, 1, 7, 5, 2], [9, 5, 7, 6, 1, 4, 2, 3, 8], [4, 3, 8, 7, 2, 9, 5, 6, 1], [6, 2, 1, 3, 5, 8, 9, 4, 7]]