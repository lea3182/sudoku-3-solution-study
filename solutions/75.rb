require_relative "screen_utils"
DEBUG =  true
BOX1 = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
BOX2 = [[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]]
BOX3 = [[0,6],[0,7],[0,8],[1,6],[1,7],[1,8],[2,6],[2,7],[2,8]]
BOX4 = [[3,0],[3,1],[3,2],[4,0],[4,1],[4,2],[4,0],[4,1],[4,2]]
BOX5 = [[3,3],[3,4],[3,5],[4,3],[4,4],[4,5],[4,3],[4,4],[4,5]]
BOX6 = [[3,6],[3,7],[3,8],[4,6],[4,7],[4,8],[4,6],[4,7],[4,8]]
BOX7 = [[6,0],[6,1],[6,2],[7,0],[7,1],[7,2],[8,0],[8,1],[8,2]]
BOX8 = [[6,3],[6,4],[6,5],[7,3],[7,4],[7,5],[8,3],[8,4],[8,5]]
BOX9 = [[6,6],[6,7],[6,8],[7,6],[7,7],[7,8],[8,6],[8,7],[8,8]]
BOXES = [ BOX1, BOX2, BOX3, BOX4, BOX5, BOX6, BOX7, BOX8, BOX9 ]
NUMBERS = [1,2,3,4,5,6,7,8,9]
class Sudoku
  attr_reader :board
  def initialize(board_string)
    @board = []
#    board_string.split("").each_slice(9) { |row| @board << row }
board_string.split("").each_slice(9) {|x| @board << x.map{|y|  y == "0" ? y = [] : y = y} }
end

def solve!
  counter = 0
  until @board.flatten.length == 81
    counter += 1
    @board.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        position = [row_index, column_index]
        determine_candidates(@board[position[0]][position[1]], position)
        puts game_status, counter
        end #row.each_with_index
      end #@board.each_with_index
    end #until
    #puts game_status, counter
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    @board.each { |row| print row; puts}
  end
   # determine candidates should take a posistion
  def determine_candidates(number, position) # area is row, box or column
    #if it is a 0, we are going to iterate through 1-9 and test candidacy,
    # if it is a candidate for that number, push that number into an array
    # if the array has length 1, position is filled with that number
    # if it has length > 1, position is filled with that array
    #puts get_coord(position) == [] #if get_coord(position) == []
    if get_coord(position).class == Array
      #candidates = []

      NUMBERS.each do |number|
        puts "NUMBERS.each #{scan_area?(position, number)}" if DEBUG
         #@board[position[0]][position[1]] = []
        if scan_area?(position, number)
          scan_area?(position, number)
          #candidates << number
          get_coord(position) << number.to_s
          puts "get_coords(position) in NUMBERS.each for position:#{position} -:- #{get_coord(position)}" if DEBUG
          #@board[position[0]][position[1]] << number.to_s
        end
        #@board[position[0]][position[1]] = @board[position[0]][position[1]][0] if @board[position[0]][position[1]].length == 1
      end
        #@board[position[0]][position[1]] = @board[position[0]][position[1]][0] if @board[position[0]][position[1]].length == 1
     if @board[position[0]][position[1]].length == 1
       @board[position[0]][position[1]] = @board[position[0]][position[1]][0]#.to_s
     else
        @board[position[0]][position[1]] = []
     end
   end
 end

    #below from methods
    missing_numbers = [] # determined by getting everything in the row/box and deleting from (1..9)
    empty_positions = [] # determined by grabbing all positions with 0

  #end

  def scan_area?(position, number)
    return true if scan_row?(position, number) && scan_column?(position,number) && scan_box?(position,number)
    puts "HIT: scan_column? passed" if  scan_column?(position,number) && DEBUG == true
    puts "HIT: scan_box?    passed" if scan_box?(position,number) && DEBUG == true
    puts "HIT: scan_row?    passed" if scan_row?(position, number) && DEBUG == true
  end
 ## still need to build out
 def scan_row?(position,number)
    #update candidate_table
    #@board[position[0]]
    #return false unless @board[position[0]].include?(number)
    #return false if @board[position[0]].reverse.include?(number.to_s)
    return false if @board[position[0]].include?(number.to_s)
    return true
  end

  def scan_column?(position,number)
    #position[1] # column_index
    column = []
    @board.each do |row|
      return false if row[position[1]] == number.to_s
      #column << row[position[1]
    end
    return true
  end

  def scan_box?(position,number)
    BOXES.each do |box|
      if box.include?(position)
        puts "box.include? method HIT" if DEBUG == true
        box.each { |box_position| return false if get_coord(position) == number.to_s}
      end
    end

    return true #unless position.get_box.include?(number)
  end

  def get_coord(position)
    #puts position.inspect
    #puts @board[3][5]
    #puts @board[position[0]][position[1]]

    return @board[position[0]][position[1]]
    #print @board[position[0]][position[1]]
  end
  def game_status
    statstring = ""
    #clear_screen!
    #puts
    #puts "HERPDERPDERP"
    #sleep(0.5)
    (0..8).each.with_index {|x,y|
      statstring << "row #{y+1} #{@board[x]} \n"
    }
    return statstring
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt')[0].chomp
board_string1 = File.readlines('sample.unsolved.txt')[1].chomp
board_string2 = File.readlines('sample.unsolved.txt')[2].chomp
board_string3 = File.readlines('sample.unsolved.txt')[3].chomp
board_string4 = File.readlines('sample.unsolved.txt')[4].chomp
board_string5 = File.readlines('sample.unsolved.txt')[5].chomp
board_string6 = File.readlines('sample.unsolved.txt')[6].chomp
board_string7 = File.readlines('sample.unsolved.txt')[7].chomp
board_string8 = File.readlines('sample.unsolved.txt')[8].chomp
board_string9 = File.readlines('sample.unsolved.txt')[9].chomp

#board_string = File.readlines('sample.unsolved.txt').second.chomp
game = Sudoku.new(board_string)
game1 = Sudoku.new(board_string1)
game2 = Sudoku.new(board_string2)
game3 = Sudoku.new(board_string3)
game4 = Sudoku.new(board_string4)
game5 = Sudoku.new(board_string5)
game6 = Sudoku.new(board_string6)
game7 = Sudoku.new(board_string7)
game8 = Sudoku.new(board_string8)
game9 = Sudoku.new(board_string9)
# Remember: this will just fill out what it can and not "guess"
#game.solve! ; puts "Game 0 solved"
game1.solve! ; puts "Game 1 solved"
=begin
game2.solve! ; puts "Game 2 solved"

game3.solve! ; puts "Game 3 solved"

game4.solve! ; puts "Game 4 solved"
game5.solve! ; puts "Game 5 solved"
game6.solve! ; puts "Game 6 solved"
game7.solve! ; puts "Game 7 solved"
game8.solve! ; puts "Game 8 solved"
game9.solve! ; puts "Game 9 solved"
=end
#game.board
#puts game.get_coord([3,5])
#game.scan_column?([0,1], 0)
#game.board