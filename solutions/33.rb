class Sudoku
  def initialize(board_string)
    @board = board_string.split('').map! {|x| x.to_i}
  end

  def get_row(cell_index)
    @board[(cell_index / 9) * 9,9] - [0]
  end

  def get_column(cell_index)
    column_index = cell_index % 9
    column_array = []
    9.times do |i|
      column_array << @board[column_index + i * 9]
    end
    column_array - [0]
  end

  def get_box( cell_index)
    boxes = {
      0 => [0,1,2,9,10,11,18,19,20],
      1 => [3,4,5,12,13,14,21,22,23],
      2 => [6,7,8,15,16,17,24,25,26],
      3 => [27,28,29,36,37,38,45,46,47],
      4 => [30,31,32,39,40,41,48,49,50],
      5 => [33,34,35,42,43,44,51,52,53],
      6 => [54,55,56,63,64,65,72,73,74],
      7 => [57,58,59,66,67,68,75,76,77],
      8 => [60,61,62, 69,70,71,78,79,80]
    }
    @box = []
    boxes.each do |key, value|
      @value = value if value.include?(cell_index)
    end
    @value.each { |cell| @box << @board[cell]}
    @box - [0]
  end

  def possible_solutions(cell_index)
    sample_array = (1..9).to_a
    return sample_array - get_row(cell_index) - get_column(cell_index) - get_box(cell_index)
  end

  def solve_cell(cell_index, n = 0)
    @board[cell_index] = possible_solutions(cell_index)[n]
  end

  def solved?
    @board.count(0) == 0
  end

  def logic_solve
    stuck = false
    until stuck == true
      stuck = true
      @board.each_with_index do |cell, cell_index|
        if @board[cell_index] == 0
          if possible_solutions(cell_index).length == 1
            solve_cell(cell_index)
            stuck = false
          end
        end
      end
    end
    return @board
  end

  def no_repeats?(cell)
    get_row(cell).uniq == get_row(cell) && get_box(cell).uniq == get_box(cell) && get_column(cell).uniq == get_column(cell)
  end

  def solve!(logic_board = logic_solve)
    next_empty_cell = @board.index(0)
    return @board if solved?
    return false if !(no_repeats?(next_empty_cell))
    possible_solutions(next_empty_cell).each do |possibility|
      @board[next_empty_cell] = possibility
      solving_board = Sudoku.new(@board.join('')).solve!
      return solving_board if solving_board
    end
    return false
  end
end


# ---
# comment out this line to enable to tests below
__END__

require 'rspec'

describe "Sudoku .solve!" do

  let(:test_board1) { Sudoku.new("096040001100060004504810390007950043030080000405023018010630059059070830003590007") }

  let(:test_board2) { Sudoku.new("302609005500730000000000900000940000000000109000057060008500006000000003019082040") }

  let(:test_board3) { Sudoku.new("030500804504200010008009000790806103000005400050000007800000702000704600610300500") }

  let(:test_board4) { Sudoku.new("000075400000000008080190000300001060000000034000068170204000603900000020530200000") }

  let(:test_board5) { Sudoku.new("300000000050703008000028070700000043000000000003904105400300800100040000968000200") }

  let(:test_board6) { Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900") }

  let(:test_board7) { Sudoku.new("005030081902850060600004050007402830349760005008300490150087002090000600026049503") }

  let(:test_board8) { Sudoku.new("290500007700000400004738012902003064800050070500067200309004005000080700087005109") }

  let(:test_board9) { Sudoku.new("080020000040500320020309046600090004000640501134050700360004002407230600000700450") }

  let(:test_board10) { Sudoku.new("608730000200000460000064820080005701900618004031000080860200039050000100100456200") }

  let(:test_board11) { Sudoku.new("370000001000700005408061090000010000050090460086002030000000000694005203800149500") }

  let(:test_board12) { Sudoku.new("000689100800000029150000008403000050200005000090240801084700910500000060060410000") }


  it 'should return 405 of length 9 when solve! is called. HUGE JOKE' do
    expect(test_board1.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. JOKE' do
    expect(test_board6.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. EASY' do
    expect(test_board7.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. MEDIUM RARE' do
    expect(test_board8.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. MEDIUM' do
    expect(test_board9.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. MEDIUM WELL' do
    expect(test_board10.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. WELL DONE' do
    expect(test_board11.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. SORT OF HARD' do
    expect(test_board12.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. HARD' do
    expect(test_board3.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. VERY HARD' do
    expect(test_board4.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. SUPER HARD' do
    expect(test_board5.solve!.flatten.inject(:+)).to eq(405)
  end

  it 'should return 405 of length 9 when solve! is called. ULTRA HARD' do
    expect(test_board2.solve!.flatten.inject(:+)).to eq(405)
  end
end
