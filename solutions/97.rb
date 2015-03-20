class Sudoku
  def initialize(board_string)
    @board = {}
    @unsolved_squares = 0
    index = 0

    for i in 1..9
      for j in 1..9
        @board[[i,j]] = [board_string[index].to_i]
        if @board[[i,j]] == [0]
          @board[[i,j]] = [1,2,3,4,5,6,7,8,9]
          @unsolved_squares += 1
        end
        @board[[i,j]] << assign_box(i,j)
        index += 1
      end
    end

  end

  #get a cord e.g. [1,2]
  #return box e.g. "A"
  def assign_box(row, col)
    case row
    when 1..3
      case col
      when 1..3
        return "A"
      when 4..6
        return "B"
      when 7..9
        return "C"
      end
    when 4..6
      case col
      when 1..3
        return "D"
      when 4..6
        return "E"
      when 7..9
        return "F"
      end
    when 7..9
      case col
      when 1..3
        return "G"
      when 4..6
        return "H"
      when 7..9
        return "I"
      end
    end
  end

  # def update_unsolved_squares
  #   @board.each_value{|value|
  #     if value.length == 2
  #       @unsolved_squares -= 1
  #     end
  #   }
  # end

  def solve!
    while @unsolved_squares > 0
      @board.each_pair { |key, value|
        if value.length > 2
          update_row(key)
          update_col(key)
          update_box(key)
          clear_screen
          move_to_home
          board
          sleep(0.07)
          if value.length == 2
            @unsolved_squares -= 1
          end
        end
      }
    end
  end

  def clear_screen
    print "\e[2J"
  end

  def move_to_home
    print "\e[H"
  end

  def update_row(cell)
    @board.each_pair do |key, value|
      if cell != key
        if key.first == cell.first && value.length == 2
          @board[cell].delete_if { | num | num == value.first }
        end
      end
    end
  end

  def update_col(cell)
    @board.each_pair do |key, value|
      if cell != key
        if key.last == cell.last && value.length == 2
          @board[cell].delete_if { | num | num == value.first }
        end
      end
    end
  end

  def update_box(coord)
  # Query the coord to get the possible_values array.
  # Look the last position from the possible_values array, e.g. 'A'
  # Look at the board and find all the values that contain 'A'
  # For those other keys in our 'A' box, get all the numbers on the board.
  # Update the board[coord] to eliminate the numbers in our same box.
  # @board[coord]

    for i in 1..9
      for j in 1..9
        if @board[[i,j]].last == @board[coord].last && [i,j] != coord && @board[[i,j]].length == 2
          @board[coord].delete(@board[[i,j]].first)
        end
      end
    end
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    print ' '
    for i in 1..9
      print i.to_s.center(30)
    end
    puts
    for i in 1..9
      print i.to_s + "  "
      for j in 1..9
        print @board[[i,j]][0..-2].to_s.center(30)
      end
      puts
    end
    puts
    puts @unsolved_squares
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('set-01_sample.unsolved.txt')

# board_string.each{ |string|
  game = Sudoku.new(board_string[0].chomp)

  # Remember: this will just fill out what it can and not "guess"
  game.solve!

  # game.board
# }