require 'pathname'

class Sudoku

  def initialize board
    @board = board.split('')
  end

  # Recursive method returns false if the attempt resulted in
  # an invalid board (so must therefore be wrong)
  def solve!
    return false unless valid?
    return @board.join if solved?

    unsolved = @board.index("0")

    (1..9).each do |possible|
      @board[unsolved] = possible
      solution = Sudoku.new(@board.join).solve!
      return solution if solution
    end

    false
  end

  #Return all the sets in the current board
  def sets
    rows = @board.each_slice(9).to_a # rows
    cols = rows.transpose
    (rows + cols + boxes).each do |set|
      set.delete("0")
    end
  end

  def boxes
    boxes = Array.new(9)
    3.times do |index|
      offset = 27 * index
      boxes[index * 3] = [
          @board[0 + offset], @board[1 + offset], @board[2 + offset],
          @board[9 + offset], @board[10 + offset], @board[11 + offset],
          @board[18 + offset], @board[19 + offset], @board[20 + offset]
      ];

      boxes[(index * 3) + 1] = [
          @board[3 + offset], @board[4 + offset], @board[5 + offset],
          @board[12 + offset], @board[13 + offset], @board[14 + offset],
          @board[21 + offset], @board[22 + offset], @board[23 + offset]
      ];

      boxes[(index * 3) + 2] = [
          @board[6 + offset], @board[7 + offset], @board[8 + offset],
          @board[15 + offset], @board[16 + offset], @board[17 + offset],
          @board[24 + offset], @board[25 + offset], @board[26 + offset]
      ];
    end
    boxes
  end

  def solved?
    @board.count("0") == 0
  end

  def has_duplicates? set
    set.uniq.length != set.length
  end

  def valid?
    sets.each do |set|
      return false if has_duplicates?(set)
    end
    true
  end

end


class Runner

  SOURCE_DIR = Pathname.new(__FILE__).dirname.realpath

  def initialize filename
    @filename = filename
  end

  def run
    failures = []
    File.readlines(SOURCE_DIR.join(@filename)).each_with_index do |puzzle, index|

      puzzle = puzzle.chomp

      unless puzzle.empty?

        game = Sudoku.new(puzzle)
        puts "WORKING ON #{index} #{@filename}"
        p puzzle
        p game.solve!
      end
    end
  end
end

Sudoku::Runner.new('set-01_sample.unsolved.txt').run
Sudoku::Runner.new('set-02_project-euler_50-easy-puzzles.txt').run