require 'debugger'
require 'benchmark'

class Sudoku

  def initialize(board_string)
    @board = board_string.split("").each_slice(9).to_a
    @candidates = [*"1".."9"]
    generate_board
  end

  def generate_board
    @rows = @board
    @columns = @rows.transpose
    @boxes = generate_boxes
  end

  def generate_boxes
    zones = Array.new(9) { Array.new }
    @board.flatten.each_with_index do |cell, index|
      zone_index = (index % 9 / 3) + (index / 9 / 3) * 3
      zones[zone_index] << cell
    end
    zones
  end

  def solve!
    replace_zero_with_candidates until solved?
    @board
  end

  def replace_zero_with_candidates
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        if cell == "0"
          # debugger
          zone_index = (cell_index / 3) + (row_index / 3) * 3
          possible_values =  @candidates - (@rows[row_index] | @columns[cell_index] | @boxes[zone_index])
          @board[row_index][cell_index] = possible_values[0] if possible_values.length == 1
          generate_board
        end
      end
    end
  end

  def solved?
    !@board.flatten.include?("0")
  end

  def to_s
    @board.map {|row| row.join("  ")}.join("\n")
  end

end

board_string = File.readlines('set-01_sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)
puts game

game.solve!
puts game

p Benchmark.bm { game.solve! }
p Benchmark.measure { 1000.times { game.solve! }}
=begin
       user     system      total        real
  0.010000   0.000000   0.010000 (  0.012061)
=end