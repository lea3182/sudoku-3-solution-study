require_relative 'racer_utils'
class Sudoku
  attr_accessor :duplicate_board, :blanks
  def initialize(board_string)
    @board = board_string.chars.map.with_index { |value, n_index| Node.new(value, n_index) }
    @blanks = []
  end

  def solve!
    refresh_blank_nodes
    sweep if @blanks.length > 0
  end

  def refresh_blank_nodes
    @blanks = []
    @board.each { |node| @blanks << node if node.value == 0 }
  end

  def sweep
    @blanks.each do |empty_node|
      impossibles = find_relative_values(row: empty_node.row, column: empty_node.column, cell: empty_node.cell)

      empty_node.potentials -= (impossibles & empty_node.potentials)
      # impossibles.each { |i| empty_node.potentials.delete(i) }
      if empty_node.potentials.length == 1
        empty_node.value = empty_node.potentials[0]
      end
    end
  end

  def find_relative_values(node_values = {})
    impossible_matches = []
    @board.each do |node|
      impossible_matches << node.value if node_values[:column] == node.column
      impossible_matches << node.value if node_values[:row] == node.row
      impossible_matches << node.value if node_values[:cell] == node.cell
    end
    impossible_matches
  end

  def draw
    @printed_board = @board.each_with_index do |node, index|
      row = (index+1) % 9 != 0
      if row
        print "#{node.value}".ljust(8)
      else
        puts node.value
      end
    end
    @printed_board
  end

  def board
  clear_screen!
    loop do
      move_to_home!
      solve!
      draw
      sleep(1.1)
      break if @blanks.length == 0
    end
    print "SOLVED! ;)".ljust(72) + "\n" if @blanks.length == 0
  end

end


class Node
  attr_accessor :row, :column, :cell, :value, :potentials
  def initialize(value, n_index)
    @row = n_index/9
    @column = n_index%9
    @cell = ((@row/3)*3) + (@column/3)
    @value = value.to_i
    @potentials = (1..9).to_a
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.

board_string = File.readlines('sample.unsolved.txt')[1].chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
# game.solve!
# game.live_display
game.board
game.solve!