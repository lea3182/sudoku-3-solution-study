class Sudoku
   attr_accessor :board_string, :puzzle_grid_in_squares, :puzzle_grid_in_rows, :puzzle_grid_in_columns

   def initialize(board_string)
      @board_string = board_string

      @puzzle_grid_in_squares = [
      [0, 1, 2, 9, 10,11,18,19,20],
      [3, 4, 5, 12,13,14,21,22,23],
      [6, 7, 8, 15,16,17,24,25,26],
      [27,28,29,36,37,38,45,46,47],
      [30,31,32,39,40,41,48,49,50],
      [33,34,35,42,43,44,51,52,53],
      [54,55,56,63,64,65,72,73,74],
      [57,58,59,66,67,68,75,76,77],
      [60,61,62,69,70,71,78,79,80]]

      @puzzle_grid_in_rows = [
      (0..8).to_a,
      (9..17).to_a,
      (18..26).to_a,
      (27..35).to_a,
      (36..44).to_a,
      (45..53).to_a,
      (54..62).to_a,
      (63..71).to_a,
      (72..80).to_a]

      @puzzle_grid_in_columns = []
      (0..80).step(9).to_a,
      (1..80).step(9).to_a,
      (2..80).step(9).to_a,
      (3..80).step(9).to_a,
      (4..80).step(9).to_a,
      (5..80).step(9).to_a,
      (6..80).step(9).to_a,
      (7..80).step(9).to_a,
      (8..80).step(9).to_a ]

   end

   def solve!
      if logic_method
         puts "returning solved string from logic_method"
         return @board_string
      else
         puts "going into recursion"
         return recursion_guess
      end
   end

   def logic_method
      zero_count_before = 0
      zero_count_after = 0
      until zero_count_before == zero_count_after
         zero_count_before = @board_string.scan(/0/).count

         for num_index in 0..80
            if @board_string[num_index] == '0'
               returning_val = compare(num_index)
               @board_string[num_index] = returning_val
            end
         end

         zero_count_after = @board_string.scan(/0/).count
      end

      @board_string.chars.include?('0') == false ? true : false

   end

   def recursion_guess
    # find the first 0 index
      first_zero = @board_string.index('0')

      all_options = find_all_options(first_zero)

    #loop through all possible values and delve into the rabbit hole
      unless all_options.size == 0
         new_string = []
         new_string = @board_string
         new_value = all_options.pop
         new_string[first_zero] = new_value.to_s
         new_game = Sudoku.new(new_string)
         solved_string = new_game.solve!
         return solved_string unless solved_string == ""
      end

      return solved_string
   end


   def compare(num_index)
      all_options = find_all_options(num_index)

      all_options.length == 1 ? all_options[0].to_s : '0'
   end

  # returns an array of all options for a given num_index
   def find_all_options(num_index)
      square_options = get_group(@puzzle_grid_in_squares,num_index)

      column_options = get_group(@puzzle_grid_in_columns,num_index)

      row_options = get_group(@puzzle_grid_in_rows,num_index)

      all_options = square_options + column_options + row_options

      find_triplets(all_options)
   end

  # takes an array of nums (some repeating)
  # grabs nums that repeat 3 times (aka a possibility for the num_index)
  # returns an array of just those nums
   def find_triplets(non_reduced_possibilities)
      non_reduced_possibilities.group_by {|e| e}.map { |e| e[0] if e[1][2]}.compact
   end

   def get_group(puzzle_grid_in_current,num_index)
      puzzle_grid_in_current.each do |group|
         return return_values_not_in_group(num_index,group) if group.include?(num_index)
      end
   end

  #returns an array of values that are possible for a particular
   def return_values_not_in_group(num_index,groups_indices)
      values_at_indices=[]
      values_not_in_group = (1..9).to_a

      groups_indices.each{|index| values_at_indices <<  @board_string[index].to_i }

      values_not_in_group.delete_if do |num|
         values_at_indices.include?(num)
      end

      values_not_in_group
   end

  def board_string
    # TODO :)
  end

  def to_s
    puts board_string
  end

end