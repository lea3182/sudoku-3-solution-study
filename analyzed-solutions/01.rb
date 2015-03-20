require 'pp'
require 'pry'

class Sudoku
  def initialize(board_string)
    generate_squares(board_string)
    @string = board_string
  end

  def solve!
    return true if add_solutions == false
    return true if @string.split("").inject(0) { |sum, n| sum + n.to_i } == 405
    @squares.each_with_index do |x, index|
      check(index)
    endboots
    add_solutions
    #trying to do a check here to see if any changes were made
    #if not, break this bad boy
    solve!
      # binding.pry
  end

  def add_solutions
    thing = @string.split("")
    string = thing.join("")
    @squares.each_with_index do |x, index|
      if x[:notes].length == 1
        x[:solution] = x[:notes].join.to_i
        @string[index] = @squares[index][:solution].to_s
        @squares[index][:notes].pop
      end
    end
    return true if @string == string
    return false
  end

  def check(index)
    unless @squares[index][:solution] > 0
      @squares.each_with_index do |obj, i|
        if obj[:row] == @squares[index][:row] && obj[:solution] > 0
          @squares[index][:notes].delete(obj[:solution])
        elsif obj[:col] == @squares[index][:col] && obj[:solution] > 0
          @squares[index][:notes].delete(obj[:solution])
        elsif obj[:block] == @squares[index][:block] && obj[:solution] > 0
          @squares[index][:notes].delete(obj[:solution])
        end
      end
    end
  end

  def to_s
    <<-strings
    ---------------
    #{@string[0..2]} | #{@string[3..5]} | #{@string[6..8]}
    #{@string[9..11]} | #{@string[12..14]} | #{@string[15..17]}
    #{@string[18..20]} | #{@string[21..23]} | #{@string[24..26]}
    - - - - - - - -
    #{@string[27..29]} | #{@string[30..32]} | #{@string[33..35]}
    #{@string[36..38]} | #{@string[39..41]} | #{@string[42..44]}
    #{@string[45..47]} | #{@string[48..50]} | #{@string[51..53]}
    - - - - - - - -
    #{@string[54..56]} | #{@string[57..59]} | #{@string[60..62]}
    #{@string[63..65]} | #{@string[66..68]} | #{@string[69..71]}
    #{@string[72..74]} | #{@string[75..77]} | #{@string[78..80]}
    ---------------
    strings
  end

def generate_squares(string)

  string = string
  stringarray = string.split('').map {|s| s.to_i}

  @squares = Array.new(81) { Hash[ :solution => nil, :row => nil, :col => nil, :block => nil, :notes => [1, 2, 3, 4, 5, 6, 7, 8, 9]] }

  stringarray.each_with_index do |value, i|
    @squares[i][:solution] = value
    if @squares[i][:solution] > 0
      @squares[i][:notes] = []
    end
  end

  @squares.each_with_index do |square, i|
    if i < 9
      square[:row] = 0
      square[:col] = i
    else
      square[:row] = (i / 9)
      square[:col] = (i % 9)
    end
  end

  @squares.each do |square|
    if square[:row] < 3
      square[:block] = 0 if square[:col] < 3
      square[:block] = 3 if square[:col] >= 3 && square[:col] < 6
      square[:block] = 6 if square[:col] >= 6
    elsif square[:row] >= 3 && square[:row] < 6
      square[:block] = 1 if square[:col] < 3
      square[:block] = 4 if square[:col] >= 3 && square[:col] < 6
      square[:block] = 7 if square[:col] >= 6
    else
      square[:block] = 2 if square[:col] < 3
      square[:block] = 5 if square[:col] >= 3 && square[:col] < 6
      square[:block] = 8 if square[:col] >= 6
    end
  end
end
end
