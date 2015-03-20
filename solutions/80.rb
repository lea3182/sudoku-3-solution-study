require 'debugger'

class Sudoku
  def initialize(board_string)
    @integer_array = board_string.split("")
    @game_board_hash = {}
    @integer_array.each_index {|index| @game_board_hash[index.divmod(9)] = @integer_array[index].to_i}
    @POSSIBLE_NUMS = (1..9).to_a
  end


  def solve!
    until @game_board_hash.has_value?(0) == false
      cell_coords =[]
      @game_board_hash.each_pair do |coords, number|
        if number == 0
          cell_coords << coords
        end
      end
      cell_coords.each {|coord_pair| solve_cell(coord_pair, find_possible_nums(merge_check_sets(check_row(coord_pair),check_column(coord_pair),check_box(coord_pair))))}
      solve!
    end
  end


  def check_row(coords)
    nums_in_row = []
    @game_board_hash.each_key {|key| nums_in_row << @game_board_hash[key] if key[0] == coords[0]}
    nums_in_row.uniq.delete_if {|number| number == 0}
  end

  def check_column(coords)
    nums_in_col = []
    @game_board_hash.each_key {|key| nums_in_col << @game_board_hash[key] if key[1] == coords[1]}
    nums_in_col.uniq.delete_if {|number| number == 0}
  end

  def check_box(coords)
    nums_in_box = []
    @game_board_hash.each_key do |key|
      if coords[0] / 3 == key[0] / 3 && coords[1] / 3 == key[1] / 3
        nums_in_box << @game_board_hash[key]
      end
    end
    nums_in_box.uniq.delete_if {|number| number == 0}
  end

  def merge_check_sets(row_nums, col_nums, box_nums)
    set_of_nums = (row_nums + col_nums + box_nums).uniq!
  end

  def find_possible_nums(set_of_nums)
    possible_cell_nums = @POSSIBLE_NUMS - set_of_nums
  end

  def solve_cell(coords, possible_cell_nums)
    if possible_cell_nums.length == 1
      @game_board_hash[coords] = possible_cell_nums[0]
    end
  end






  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    print "----------------------\n"
    @game_board_hash.each_pair do | coord, number |
      print number.to_s + " "
      print "| " if coord.last == 2 || coord.last == 5
      print "\n" if coord.last == 8
      print "----------------------\n" if coord == [2,8] || coord == [5,8]
    end
      print "----------------------\n"
   end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
# game.solve!
game.solve!
puts game.board
# p game.check_box([0,0])




#prepare board
# turn the string of integers into an array of integers
# map that to a hash with coords as a key (divmod)


