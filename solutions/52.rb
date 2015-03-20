class Sudoku
  attr_reader :board
  def initialize(board_string)
    @board_string = board_string
    @board = gather_options
  end

  def row_neighbors(index)
    row = index/9
    return (0..8).to_a.map { |e| e + row*9 }
  end

  def col_neighbors(index)
    col = index%9
    return (0..8).to_a.map { |e| e*9 + col }
  end

  def box_neighbors(index)
    row = (index/9)/3
    col = (index%9)/3
    return (0..80).to_a.select do |e|
      (e/9)/3 == row && (e%9)/3 == col
    end
  end

  def all_neighbors(index)
    all_indices = (0..80).to_a
    row_neighbors = row_neighbors(index)
    col_neighbors = col_neighbors(index)
    box_neighbors = box_neighbors(index)
    all_but_neighbors = all_indices - row_neighbors - col_neighbors - box_neighbors
    return (0..80).to_a - all_but_neighbors - [index]
  end

  def options(index)
    neighbors = all_neighbors(index)
    options = (1..9).to_a
    if @board_string[index] != "-"
      return [@board_string[index].to_i]
    else
      neighbors.each do |e|
        if @board_string[e] != "-"
          options.delete(@board_string[e].to_i)
        end
      end
    end
    return options
  end

  def gather_options
    output = []
    @board_string.chars.each_index { |i| output << options(i) }
    output
  end

  def delete_from_neighbors(index, new_board, number)
    modded_board = Marshal.load( Marshal.dump(new_board) )
    all_neighbors(index).each do |i|
      modded_board[i].delete(number)
    end
    modded_board
  end

  # def delete_from_neighbors(index, board, number)
  #   local_board = board.dup
  #   all_neighbors(index).each do |i|
  #     local_board[i].delete(number)
  #   end
  #   local_board
  # end

  def print_board(game_board)
    game_board.each_slice(9) do |slice|
      p slice
    end
  end

  def move(cell_index = 0, move_board = @board, depth = 0)
    # gets
    # print_board(move_board)
    return false if move_board.any?(&:empty?)
    if cell_index == 80 && move_board[cell_index].size == 1
      print_board(move_board)
      return true
    end
    move_board[cell_index].each do |possibility|
      new_board = Marshal.load( Marshal.dump(move_board) )
      new_board[cell_index] = [possibility]
      if move(cell_index+1, delete_from_neighbors(cell_index, new_board, possibility), depth+1)
        return true
      end
    end
    return false


    # return "solved" if cell_index == 80 && board[cell_index] != []
    # if board.any?(&:empty?)
    #   p "dead end when index is #{cell_index}"
    # else
    #   board[cell_index].each do |possibility|
    #     local_board = board.dup
    #     local_board[cell_index] = [possibility]
    #     puts "This is the local board:"
    #     print_board(local_board)
    #     return "solved" if move(cell_index+1, delete_from_neighbors(cell_index, local_board, possibility)) == "solved"
    #   end
    # end
  end

  def solve
    p move
  end

  # Returns a string representing the current state of the board
  def to_s
  end
end