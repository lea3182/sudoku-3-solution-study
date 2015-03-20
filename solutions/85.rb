class Sudoku
  attr_reader :master_board
  def initialize(board_string)
    @board_string = board_string.to_s
    @master_board = []
    @rows = Hash.new(0)
    @columns = Hash.new(0)
    @boxes = Hash.new(0)
    @possibles_array = []
    @compare_array = %w(1 2 3 4 5 6 7 8 9)
  end

  # def update_rows
  #   row_key = 1
  #   @master_board.each do |row|
  #     @rows[row_key] = row
  #     row_key += 1
  #   end
  #   @rows
  # end

  def update_rows
    @master_board.each_with_index do |row, index|
      @rows[index] = row
    end
    @rows
  end

  def update_columns
  transpose_board = @master_board.transpose
  transpose_board.each_with_index do |column, index|
  @columns[index] = column
  end
  end

  # def update_columns
  #   column_key = 1
  #   transpose_board = @master_board.transpose
  #   transpose_board.each do |column|
  #     @columns[column_key] = column
  #     column_key += 1
  #   end
  #   @columns
  # end

  def update_boxes
    @boxes[1] = @master_board[0][0..2].zip(@master_board[1][0..2], @master_board[2][0..2]).flatten
    @boxes[2] = @master_board[0][3..5].zip(@master_board[1][3..5], @master_board[2][3..5]).flatten
    @boxes[3] = @master_board[0][6..9].zip(@master_board[1][6..9], @master_board[2][6..9]).flatten
    @boxes[4] = @master_board[3][0..2].zip(@master_board[4][0..2], @master_board[5][0..2]).flatten
    @boxes[5] = @master_board[3][3..5].zip(@master_board[4][3..5], @master_board[5][3..5]).flatten
    @boxes[6] = @master_board[3][6..9].zip(@master_board[4][6..9], @master_board[5][6..9]).flatten
    @boxes[7] = @master_board[6][0..2].zip(@master_board[7][0..2], @master_board[8][0..2]).flatten
    @boxes[8] = @master_board[6][3..5].zip(@master_board[7][3..5], @master_board[8][3..5]).flatten
    @boxes[9] = @master_board[6][6..9].zip(@master_board[7][6..9], @master_board[8][6..9]).flatten

    @boxes
  end

  def easy_board
    format_board = []
   @master_board.each do |x|
    p x


  end
  p "---------------------"
  end


  def search_first_empty
    missing_numbers = []
    @master_board.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        @possibles_array = []
        if cell == "0"
          @possibles_array << @rows[row_index]
          @possibles_array << @columns[cell_index]
            col_var = ((cell_index / 3) + 1)
            row_var = ((row_index/3) *3)
            coord_var = row_var + col_var

          @possibles_array << @boxes[coord_var]
          @possibles_array.flatten!
          @possibles_array.uniq!
          missing_numbers = @compare_array - @possibles_array

          if missing_numbers.count == 1
            missing_numbers = missing_numbers.join("")
            @master_board[row_index][cell_index].replace(missing_numbers)
          else
            nil
          end










          # @possibles_array.sort!
          # @possibles_array =  @possibles_array.select {|x| x != "0"}
          # @possibles_string = @possibles_array.join("")
          # @possibles_string = @possibles_string.scan(/(\d)\1{2,}/) # checks for three in a row

          # takes values of row counter from @rows , push to some temp structure
          # takes values of cell_index from @columns, push to some temp structure
          # figures out what box it is in ???, push to temp structure
            # [2,2,3,3,4] and then search match 3 and unique
              # if that happens, push that value to @master_board at place row_couter cell_index


        else
          nil
        end
      end

    end
    easy_board
  end

  def board
    # until  @board_string.length == 0 do
      #sub_array = @board_string.split("").slice!(0..8)
      @master_board << @board_string.split("").slice!(0..8)
      @master_board << @board_string.split("").slice!(9..17)
      @master_board << @board_string.split("").slice!(18..26)
      @master_board << @board_string.split("").slice!(27..35) # we know
      @master_board << @board_string.split("").slice!(36..44)
      @master_board << @board_string.split("").slice!(45..53)
      @master_board << @board_string.split("").slice!(54..62)
      @master_board << @board_string.split("").slice!(63..71)
      @master_board << @board_string.split("").slice!(72..80)

      @master_board

  end

  def solve!
      # search first all the way through somehow
      # is solved?
      # update rows, col, boxes,
      # recurse solve
      search_first_empty
      update_columns
      update_rows
      update_boxes
      @master_board.each do |row|
        if row.include?("0")
          solve!
        else
           easy_board
          puts "You are awesome!"
          break
      end
    end

  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.


end #class end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
 game.board
game.solve!

        #DONT COMMENT OUT
#   game.easy_board
#  game.update_rows     #DONT COMMENT OUT
#  game.update_columns  #DONT COMMENT OUT
#  game.update_boxes    #DONT COMMENT OUT


# p game.search_first_empty
# # p game.master_board

# CAN we come up with a box number based on coordinates???
# if x is in (0..2) and y is in (0..2) then box number = 1
# if x


