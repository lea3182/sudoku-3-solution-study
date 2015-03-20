class Sudoku
  def initialize(board_string)
    given_board = board_string.split(//)
    @board = (1..9).map {(1..9).map {Cell.new(given_board.shift)}}
  end

  def solve!
    while @board.map {|i| i.map {|cell| cell.solution}}.flatten.include?("_") do
      create_minisquare
      create_minisquare_poss

      @board.each do |row|
        row.each do |cell|

          row_reduce(row,cell)
          col_reduce(row,cell)
          block_reduce(row,cell)

          row_poss_reduce(row,cell)
          col_poss_reduce(row,cell)
        end
      end

      @board.each {|row| row.each {|cell| cell.solved?} }
      board
      #sleep(1)
    end
    to_s
  end

  def row_reduce(row,cell)
    @row_solutions = @board.map {|line| line.map {|space| space.solution }}
    @row_solutions[@board.find_index(row)].each { |answer| cell.possibilities.delete(answer)}
  end

  def col_reduce(row,cell)
    @column_solutions = @board.transpose.map {|line| line.map {|space| space.solution }}
    @column_solutions[row.find_index(cell)].each { |answer| cell.possibilities.delete(answer)}
  end

  def block_reduce(row,cell)
    index = (3*(@board.find_index(row)/3))+(row.find_index(cell)/3)
    @block_solutions[index].each {|answer| cell.possibilities.delete(answer) }
  end

  def row_poss_reduce(row,cell)
    @row_poss = @board.map {|line| line.map {|space| space.possibilities }}
    cell.possibilities.each do |pos|
      if @row_poss[@board.find_index(row)].flatten.count(pos) == 1
        cell.solution, cell.possibilities = pos, []
      end
    end
  end

  def col_poss_reduce(row,cell)
#    @col_poss = @board.transpose.map {|line| line.map {|space| space.possibilities }}
#    cell.possibilities.each do |pos|
#      if @col_poss[@board.find_index(row)].flatten.count(pos) == 1
#        cell.solution, cell.possibilities = pos, []
#      end
#    end
  end

  def create_minisquare
    @block_solutions = []
    tri_block = @board.each_slice(3).to_a

    3.times do |i|
      tri_block[i].map! {|row| row.map {|cell| cell.solution }}
      3.times {|k| tri_block[i][k] = tri_block[i][k].each_slice(3).to_a}
      3.times {|k| @block_solutions << tri_block[i][0][k] + tri_block[i][1][k] + tri_block[i][2][k]}
    end
  end

  def create_minisquare_poss
    @block_poss = []
    tri_block = @board.each_slice(3).to_a

    3.times do |i|
      tri_block[i].map! {|row| row.map {|cell| cell.possibilities }}
      3.times {|k| tri_block[i][k] = tri_block[i][k].each_slice(3).to_a}
      3.times {|k| @block_poss << tri_block[i][0][k] + tri_block[i][1][k] + tri_block[i][2][k]}
    end
  end

  def board
    print "\e[2J\n\e[H"
    @board.each{|row|
      puts "| #{row.map {|cell| cell.solution }.join(" | ")} |"
      puts "-------------------------------------"
    }
  end

  def to_s
    @board.map {|i| i.map {|cell| cell.solution}}.flatten.join
  end
end

class Cell
  attr_accessor :possibilities, :solution

  def initialize(sudoku_number)
    if sudoku_number.to_i == 0
      @solution, @possibilities = "_", [1,2,3,4,5,6,7,8,9]
    else
      @solution, @possibilities = sudoku_number.to_i, []
    end
  end

  def solved?
    @solution = @possibilities.pop if @possibilities.length == 1
  end
end

sud = Sudoku.new("300000000050703008000028070700000043000000000003904105400300800100040000968000200")
sud.solve!
sud.to_s