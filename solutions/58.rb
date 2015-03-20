class Sudoku

  def initialize(board_string)
    @input = board_string
    @stack = []
    @comp_board
    # compute_board
  end

  # def  compute_board
  #     @comp_board = @input.split("").each_slice(9).to_a.each { |row| row.map! {|num| num.to_i == 0 ? (1..9).to_a : num.to_i }}

  # end
  #Input @comp_board
  #outpu refreshed @comp_board
  def refresh

  end
  def format_boxes
    @grid_board = []

    @comp_board.each_slice(3) do |row_set|
      grid_tmp = [[],[],[]]
      row_set.each { |row| row.each_slice(3).with_index { |s,i| grid_tmp[i] = grid_tmp[i] + s } }
      @grid_board +=  grid_tmp
    end

  end #return #grid_board



  #####FINDING POSSIBILITIES
  #INPUT @COMP_BOARD
  #OUTPUT @stack
  def column_integers(counter_column)
    @comp_board.transpose[counter_column].each{ |e| (@stack << e if e > 0) if e.is_a? Integer }
  end

  def row_integers(counter_row)
    @comp_board[counter_row].each { |e| (@stack << e if e > 0) if e.is_a? Integer }
  end
  def box_integers(box)
    self.format_boxes[box].each { |e| (@stack << e if e > 0) if e.is_a? Integer }
  end


  #replaces values at cells and solves board incrementally
  #input @comp_board, @stack
  #output answers

  def solve! ##This needs to work with the finding posibilities
    counter_row = 0
    counter_column = 0
    while ((counter_row < 82) && (counter_column < 82))

      #binding.pry
      answer = @comp_board[counter_row][counter_column] - @stack

      if answer.length == 1
        @comp_board[counter_row][counter_column] = answer[0].to_i # <- these are whats sposed to be returned
      end
    end
    counter_row += 1
    counter_column += 1
    @comp_board
  end

end

# Returns a string representing the current state of the board
# Don't spend too much time on this method; flag someone from staff
# if you are.
#DISPLAYING BOARD TO STRING
def board
  @comp_board #do stuff to make it pretty
end

end # END SUDOKU

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp
input = "530070000600195000098000060800060003400803001700020006060000280000419005000080079"
game = Sudoku.new(input)

game.solve! #solve the game!
game.board #print out the solved board

# Remember: this will just fill out what it can and not "guess"


# p game.format_rows
# p game.format_columns