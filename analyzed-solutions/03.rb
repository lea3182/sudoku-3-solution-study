require 'pp'

class Sudoku
  attr_reader :board, :unsolved_data

  def initialize(board_string)
    @board = board_string.split("").each_slice(1).to_a
    @unsolved_data = []
  end

  def seed
    @board.map do |x|
      if x.include?("0")
        x.shift
        x.push("1", "2", "3", "4", "5", "6", "7", "8", "9")
      end
    end
    return @board
  end

  def get_column(index)
    column = []
    cloned_board = @board.clone
    9.times do
      column << cloned_board.slice!(0,9).to_a
    end
    column_array = []
    column.each do |col|
      column_array << col[index]
    end
    @unsolved_data = column_array
    @unsolved_data
  end

  def get_row(index)
    case index
    when(0..8)
      @unsolved_data = @board[0..8]
    when(9..17)
      @unsolved_data =  @board[9..17]
    when(18..26)
      @unsolved_data = @board[18..26]
    when(27..35)
      @unsolved_data = @board[27..35]
    when(36..44)
      @unsolved_data = @board[36..44]
    when(45..53)
      @unsolved_data = @board[45..53]
    when(54..62)
      @unsolved_data = @board[54..62]
    when(63..71)
      @unsolved_data = @board[63..71]
    when(72..80)
      @unsolved_data = @board[72..80]
    end
    @unsolved_data
  end

  def get_grid(input_array, quad_num)
    output_array = Array.new

    case quad_num
      when 0 then quad_num = 0
      when 1 then quad_num = 3
      when 2 then quad_num = 6
      when 3 then quad_num = 27
      when 4 then quad_num = 30
      when 5 then quad_num = 33
      when 6 then quad_num = 54
      when 7 then quad_num = 57
      when 8 then quad_num = 60
    end

    3.times {
      3.times { output_array.push(input_array[quad_num]); quad_num += 1 }
      quad_num += 6 }

    @unsolved_data = output_array

  end

  # Input = output of get_col (ie. column = [["1"], ["1", "2", "3", "4", "5", "6", "7", "8", "9"], ["5"], ["8"], ["1", "2", "3", "4", "5", "6", "7", "8", "9"], ["2"], ["1", "2", "3", "4", "5", "6", "7", "8", "9"], ["1", "2", "3", "4", "5", "6", "7", "8", "9"], ["1", "2", "3", "4", "5", "6", "7", "8", "9"]])
  def evaluate
    #for each item in the get_col array, return contents of all one-item arrays(length == 1) and flatten
    #compare items in single-item arrays with each multi-item array.  if items match, remove item from multi-item array.
    #return updated @board
    solved = @unsolved_data.select{|item| item.length == 1}.flatten
    @unsolved_data.select{|item| item.length > 1}.each do |unsolved|
      unsolved.reject!{|item| solved.include? item }
    end
    @unsolved_data
  end

  def solve!
    seed
    (0..8).each { |e| get_grid(@board, e); evaluate }
    (0..8).each { |e| get_column(e); evaluate }
    (0..8).each { |e| get_row(e); evaluate }
    (0..72).step(9) { |e| get_row(e); evaluate }
    solved?
  end

  # def print_array(board = @board, num_per_line=9)
  #   # board.each_slice(num_per_line) { |e| print "#{e}\n" }
  #   ctr = 0
  #   board.each_slice(num_per_line) { |e|
  #     puts " ---------------------" if ctr % 3 == 0
  #     e.insert(3, "|"); e.insert(7, "|")
  #     puts " #{e.join(" ")}"
  #     ctr += 1
  #   }
  #   puts " ---------------------\n\n"
  # end

    def print_array
    ctr = 0
    num_per_line = 9
    @board.each_slice(num_per_line) { |e|
      puts " ---------------------" if ctr % 3 == 0
      e.insert(3, "|"); e.insert(7, "|")
      puts " #{e.join(" ")} "
      ctr += 1
    }
    puts " ---------------------\n\n"
  end


  def solved?
    # for each array if array.length > 1, rerun solve!
    # else solve!
    if @board.all? {|item| item.length == 1}
      return print_array
    else
      solve!
    end
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  #   def to_s

  #   end
end