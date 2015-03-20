class Sudoku
  attr_accessor :duplicate_board
  def initialize(board_string)
    @board_string = board_string

    @duplicate_board = board_string.chars.map.with_index do |node, n_index|
      Node.new(node, n_index)
    end
    @blanks = []
  end

  def solve!
    refresh_blank_nodes
    if @blanks.length > 0
      puts "blanks.length: #{@blanks.length}"
      sweep
      solve!
    else
      puts "done!"
      return board
    end
  end

  def refresh_blank_nodes
    @blanks = []
    @duplicate_board.each do |node|
      @blanks << node if node.value == 0
    end
  end

  def sweep
    @blanks.each do |empty_node|
      emptys_column = empty_node.column
      emptys_row = empty_node.row
      emptys_cell = empty_node.cell

      all_impossible_values = find_row_values(emptys_row) + find_column_values(emptys_column) + find_cell_values(emptys_cell)
      unique_impossibles = all_impossible_values.uniq
      unique_impossibles.delete(0)
      unique_impossibles.each do |i|
        empty_node.potentials.delete(i)
      end
      if empty_node.potentials.length == 1
        empty_node.value = empty_node.potentials[0]
      end
    end
  end

  def find_row_values(row)
    @currentarray = []
    @duplicate_board.each do |node|
      @currentarray << node.value if node.row == row
    end
    @currentarray
  end

  def find_column_values(column)
    @currentarray = []
    @duplicate_board.each do |node|
      @currentarray << node.value if node.column == column
    end
    @currentarray
  end

  def find_cell_values(cell)
    @currentarray = []
    @duplicate_board.each do |node|
      @currentarray << node.value if node.cell == cell
    end
    @currentarray
  end


  def board
    @printed_board = @duplicate_board.each_with_index do |node, index|
      if (index+1) % 9 != 0
        print "#{node.value}".ljust(4)
      else
        puts node.value
      end
    end
    @printed_board
  end
end

class Node
  attr_accessor :row, :column, :cell, :value, :potentials

  def initialize(value, n_index)
    @row = n_index/9
    @column = n_index%9
    @cell = assign_cell
    @value = value.to_i
    @potentials = (1..9).to_a
  end

  def assign_cell
    if @row >= 0 && @row <= 2
      if @column >=0 && @column <=2
        return 1
      end
      if @column >=3 && @column <=5
        return 2
      end
      if @column >=6 && @column <=8
        return 3
      end
    end

    if @row >= 3 && @row <= 5
      if @column >=0 && @column <=2
        return 4
      end
      if @column >=3 && @column <=5
        return 5
      end
      if @column >=6 && @column <=8
        return 6
      end
    end

    if @row >= 6 && @row <= 8
      if @column >=0 && @column <=2
        return 7
      end
      if @column >=3 && @column <=5
        return 8
      end
      if @column >=6 && @column <=8
        return 9
      end
    end
    # return (((@row/3)*3)+(@column%3)+1).to_i
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
# game.solve!

game.board
game.solve!



# p game.board[2].class

=begin
NOTES:

class Sudoku
  attr_accessor :duplicate_board
  def initialize(board_string)
    @board_string = board_string

    @duplicate_board = board_string.chars.map.with_index do |node, n_index|
      Node.new(node, n_index)
    end
    @blanks = []
  end

  def solve!
    refresh_blank_nodes
    if @blanks.length > 0
      puts "blanks.length: #{@blanks.length}"
      sweep
      solve!
    else
      puts "done!"
      return board
    end
  end

  def refresh_blank_nodes
    @blanks = []
    @duplicate_board.each do |node|
      @blanks << node if node.value == 0
    end
  end

  def sweep
    @blanks.each do |empty_node|
      emptys_column = empty_node.column
      emptys_row = empty_node.row
      emptys_cell = empty_node.cell

      all_impossible_values = find_row_values(emptys_row) + find_column_values(emptys_column) + find_cell_values(emptys_cell)
      unique_impossibles = all_impossible_values.uniq
      unique_impossibles.delete(0)
      unique_impossibles.each do |i|
        empty_node.potentials.delete(i)
      end
      if empty_node.potentials.length == 1
        empty_node.value = empty_node.potentials[0]
        board
        puts "----"
      end
    end
  end

  def find_row_values(row)
    @currentarray = []
    @duplicate_board.each do |node|
      @currentarray << node.value if node.row == row
    end
    @currentarray
  end

  def find_column_values(column)
    @currentarray = []
    @duplicate_board.each do |node|
      @currentarray << node.value if node.column == column
    end
    @currentarray
  end

  def find_cell_values(cell)
    @currentarray = []
    @duplicate_board.each do |node|
      @currentarray << node.value if node.cell == cell
    end
    @currentarray
  end


  def board
    @printed_board = @duplicate_board.each_with_index do |node, index|
      if (index+1) % 9 != 0
        print "#{node.value}".ljust(4)
      else
        puts node.value
      end
    end
    @printed_board
  end
end

class Node
  attr_accessor :row, :column, :cell, :value, :potentials

  def initialize(value, n_index)
    @row = n_index/9
    @column = n_index%9
    @cell = assign_cell
    @value = value.to_i
    @potentials = (1..9).to_a
  end

  def assign_cell
    if @row >= 0 && @row <= 2
      if @column >=0 && @column <=2
        return 1
      end
      if @column >=3 && @column <=5
        return 2
      end
      if @column >=6 && @column <=8
        return 3
      end
    end

    if @row >= 3 && @row <= 5
      if @column >=0 && @column <=2
        return 4
      end
      if @column >=3 && @column <=5
        return 5
      end
      if @column >=6 && @column <=8
        return 6
      end
    end

    if @row >= 6 && @row <= 8
      if @column >=0 && @column <=2
        return 7
      end
      if @column >=3 && @column <=5
        return 8
      end
      if @column >=6 && @column <=8
        return 9
      end
    end
  end
end
=end