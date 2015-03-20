class Sudoku
  attr_reader :index_board

  def initialize(board_string)
    @board_string = board_string
    @initial = @board_string.split("").map!{|num|
      num.to_i
    }
    @box_positions = %w(
        0 1 2 9 10 11 18 19 20
        3 4 5 12 13 14 21 22 23
        6 7 8 15 16 17 24 25 26
        27 28 29 36 37 38 45 46 47
        30 31 32 39 40 41 48 49 50
        33 34 35 42 43 44 51 52 53
        54 55 56 63 64 65 72 73 74
        57 58 59 66 67 68 75 76 77
        60 61 62 69 70 71 78 79 80
    )
  end

  def solve
    until @guess_board.flatten.length == 81
      self.check
    end
    @guess_board.each{|x| p x.join("  ")}
  end

  def board
    @guess_board = []
    @board_string.split("").each_with_index{|value|
      if value == "-"
        @guess_board << (1..9).to_a
      else
        @guess_board << [value.to_i]
      end
    }
    @guess_board = Array.new(9) {@guess_board.shift(9)}
  end

  def create_base
    # puts "==============================="
    self.create_row_base
    # puts "==============================="
    self.create_column_base
    # puts "==============================="
    self.create_box_base
    # puts "==============================="
  end

  def create_row_base
    @row_initial = @initial.clone
    @rows = Array.new(9) {@row_initial.shift(9)}
    # @rows.each{|x| p x}
  end

  def create_column_base
    @columns = @rows.transpose
    # @columns.each{|x| p x}
  end

  def create_box_base
    @box_initial = @initial.clone
    @box = []

    @box_positions.each{|num|
      @box << @box_initial[num.to_i]
    }
    @new_box = Array.new(9) {@box.shift(9)}
    # @new_box.each{|x| p x}
  end

  def check
    self.create_base
    self.check_row
    self.create_base
    self.check_column
    self.create_base
    self.check_box
    self.create_base

  end

  def update_master
    @initial = []
    @guess_board.each{|row|
      row.each{|elem|
        if elem.length != 1
          @initial << 0
        else
          @initial << elem[0]
        end
      }
    }
  end

  def check_row
    @rows.each_with_index{|row,index|
      @guess_board[index].map!{|cell|
        if cell.length != 1
          cell.delete_if{|elem| row.include?(elem)}
        else
          cell
        end
      }
    }
    # @guess_board.each{|x| p x}
    self.update_master
  end

  def check_box
    @guess_box_initial = @initial.clone
    @guess_board_boxed = []
    @box_positions.each{|num|
      @guess_board_boxed << @guess_board.flatten(1)[num.to_i]
    }
    @new_guess_board_boxed = Array.new(9) {@guess_board_boxed.shift(9)}
    @new_box.each_with_index{|box,index|
      @new_guess_board_boxed[index].map!{|cell|
        if cell.length != 1
          cell.delete_if{|elem| box.include?(elem)}
        else
          cell
        end
      }
    }
    @guess_board = []
    @box_positions.each_with_index{|num,index|
      @guess_board[num.to_i] = @new_guess_board_boxed.flatten(1)[index]
    }
    @guess_board = Array.new(9) {@guess_board.shift(9)}
    # @guess_board.each{|x| p x}
    self.update_master
  end

  def check_column
    @columns.each_with_index{|col,index|
      @guess_board.transpose[index].map!{|cell|
        if cell.length != 1
          cell.delete_if{|elem| col.include?(elem)}
        else
          cell
        end
      }
    }
    # @guess_board.each{|x| p x}
    self.update_master
  end
end


# test = Sudoku.new("145893276892176435673425819519762384247583961386194752957438621614729358238561947")
# test = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")
# test.board
# test.solve
# test.create_box_base

# p test.index_board[22].coordinates








