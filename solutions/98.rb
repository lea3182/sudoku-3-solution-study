class Sudoku
  attr_reader :all_values, :row, :column, :collection, :box_number, :box_values, :column_values,:row_values, :collection, :possible_solutions

  def initialize(board_string)

   @collection          = []
   @all_values          = board_string.split('')
  end

#===========================#
# Reset Box Row Col Values  #
#===========================#

  def reset_box_row_col_values
    make_box_arrays
    make_rows_arrays
    make_cols_arrays
  end

   def make_box_arrays
     @box_values    = Array.new(9){Array.new()}

     @all_values.each_with_index do |number, index|
       row              = get_row(index)
       column           = get_column(index)
       box_number       = get_box_number(row,column)

       @box_values[box_number] << number
     end

   end

   def make_rows_arrays
     row_values   = @all_values.clone
     @row_values  = Array.new(9){row_values.shift(9)}
   end

   def make_cols_arrays
      @column_values =  @row_values.transpose
   end

#===========================#
# Find Row Col Box Values   #
#===========================#

def find_row_column_box_num(index)
   get_row(index)
   get_column(index)
   get_box_number(@row,@column)
  end

  def get_row(index)
    @row = index/9
  end

  def get_column(index)
    @column = index % 9
  end

  def get_box_number(row,column)
    box_row_number = (row/3)*3
    box_column_number = (column/3)
    @box_number = box_row_number + box_column_number

  end

#==================#

  def solve!
    return @all_values if !@all_values.include?("0")
    reset_box_row_col_values

    @all_values.each_with_index do |number, index|
      if number == '0'
       make_collection(index)
       get_possible_solutions

         if @possible_solutions.length == 1
           @all_values[index] = @possible_solutions[0]
         end
      end
    end # END EACH
    solve!
  end #END SOLVE

  def make_collection(index)
    @collection = []
    find_row_column_box_num(index)
    @collection = @box_values[@box_number] + @column_values[@column] + @row_values[@row]
    @collection.uniq!.sort!.delete("0")
    @collection
  end

  def get_possible_solutions
    @possible_solutions = []
    digits = (1..9).to_a.map!{|num| num.to_s}
    @possible_solutions = digits - @collection
    @possible_solutions
  end

end



# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
#board_string = File.readlines('set-01_sample.unsolved.txt').first.chomp

game = Sudoku.new('619030040270061008000047621486302079000014580031009060005720806320106057160400030')
game.make_box_arrays
# p game.all_values

# puts "\n\n"
# puts "Make Collection Method"
# array=["0","3","1","0","0","9","0","6","0", "3","0","2","0","1","4","0","0","9", "0", "1","7","2","4","9","0","6","0"]
# array.uniq!.sort!.delete("0")
#  p game.make_collection(50) == array

# puts "\n\n"
# puts "Test Find Row Column Box Number"
# game.find_row_column_box_num(50)
# puts game.row == 5
# puts game.column == 5
# puts game.box_number == 4

# puts "\n\n"
# puts "Test For Possible Solutions"
# p game.get_possible_solutions == ["5", "8"]

puts "\n\n"
puts "Test For Find All Values"
printed_array = game.solve!



puts "---------------------"
final_values = Array.new(9){Array.new(game.all_values.shift(9))}
  final_values.each_with_index do |row,index|
    if (index + 1) % 3 == 0
    sliced = row.each_slice(3).to_a
    string_section = []
      sliced.each do |section|
        string_section << section.join(" ")
      end
      puts string_section.join(" | ")
      puts "---------------------"
    else
      sliced = row.each_slice(3).to_a
      string_section = []
      sliced.each do |section|
        string_section << section.join(" ")
      end
      puts string_section.join(" | ")
    end
  end


# puts "\n\n"
# puts "Final Values!!!"
# final_values = Array.new(9){Array.new(game.all_values.shift(9))}

# p final_values[0].sort
# p final_values[1].sort
# p final_values[2].sort
# p final_values[3].sort
# p final_values[4].sort
# p final_values[5].sort
# p final_values[6].sort
# p final_values[7].sort
# p final_values[8].sort





