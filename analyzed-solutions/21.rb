class Sudoku
  def initialize(board_string)
    @board_string = board_string
    @possible_nums = [1,2,3,4,5,6,7,8,9]
  end

  def solve!
    x= 0
    y=0
    zero_array = []
while y < 9
  x = 0
    while x < 9
      if @board_string[y][x] == 0
        zero_array << [y,x]
      end
      x += 1
    end
  y += 1
end

# p zero_array
    counter = 0
    col_coord = []
    board_counter = 0
while board_counter < @board_string.length #iterate over the beginning position of the top row ->,->,->
  @board_string[0][board_counter]
  counter = 0
  9.times do
    col_coord << @board_string[counter][board_counter]
    counter +=1
  end
  board_counter += 1
end
col_final = col_coord.each_slice(9).to_a
p "this is our final col array #{col_final}"


    box_array =[]
    x_begin_point = 0
    y_begin_point = 0
    until y_begin_point > 8
     (x_begin_point..x_begin_point+2).each do |x|
      (y_begin_point..y_begin_point+2).each do |y|
        box_array << board[x][y]
      end
    end
    y_begin_point+=3
  end


  x_begin_point = 3
  y_begin_point = 0
  until y_begin_point > 8
   (x_begin_point..x_begin_point+2).each do |x|
    (y_begin_point..y_begin_point+2).each do |y|
      box_array << board[x][y]
    end
  end
  y_begin_point+=3
end

  x_begin_point = 6
  y_begin_point = 0
  until y_begin_point > 8
   (x_begin_point..x_begin_point+2).each do |x|
    (y_begin_point..y_begin_point+2).each do |y|
      box_array << board[x][y]
    end
  end
  y_begin_point+=3
end


box_final = box_array.each_slice(9).to_a

counter = 0
while counter <= @board_string[0].length
  if @board_string[0][counter] == 0
    @board_string[0].include? @board_string[0][counter]

        #@board_string[0][counter] = @possible_nums.sample
      end
      counter +=1
    end
    row_final = @board_string

     q0 = [[0,0], [0,1], [0,2],
       [1,0], [1,1], [1,2],
       [2,0], [2,1], [2,2]]

 q1 = [[0,3], [0,4], [0,5],
       [1,3], [1,4], [1,5],
       [2,3], [2,4], [2,5]]

 q2 = [[0,6], [0,7], [0,8],
       [1,6], [1,7], [1,8],
       [2,6], [2,7], [2,8]]

 q3 = [[3,0], [3,1], [3,2],
       [4,0], [4,1], [4,2],
       [5,0], [5,1], [5,2]]

 q4 = [[3,3], [3,4], [3,5],
       [4,3], [4,4], [4,5],
       [5,3], [5,4], [5,5]]

 q5 = [[3,6], [3,7], [3,8],
       [4,6], [4,7], [4,8],
       [5,6], [5,7], [5,8]]

 q6 = [[6,0], [6,1], [6,2],
       [7,0], [7,1], [7,2],
       [8,0], [8,1], [8,2]]

 q7 = [[6,3], [6,4], [6,5],
       [7,3], [7,4], [7,5],
       [8,3], [8,4], [8,5]]

 q8 = [[6,6], [6,7], [6,8],
       [7,6], [7,7], [7,8],
       [8,6], [8,7], [8,8]]

@quadrants = [q0, q1, q2, q3, q4, q5, q6, q7, q8]

# def check_quadrant([2,1])
#[2,1]
  # quadrants.each{ |quadrants| quadrants.each{|find| find.include?([2,1])} }

list = @quadrants.flatten(1)

    # p "this is our final row array #{row_final}"
# p zero_array


#### Above this is just defining arrays #####

#do .include on its box, row, col
#if the remaining length of the possible num is equal to 1, replace zero with that number
#if the remaining length is not equal to 1, skip to the next square
#game_solved = true if no zero's in anny of the arrays

# col_final
# row_final
# box_final

# if @board_string[x][y] == 0
#   cell_array = @possible_nums
#   cell_array.delete_if {|num| col_final[y].include? num}
#   cell_array.delete_if {|num| row_final[x].include? num}
#   cell_array.delete_if {|num| box_final[y].include? num}

  list.each_with_index do |pair,index|
    if pair == [0,1]
      puts "this is the #{index}"
    end
  end

# end
# zero_array_counter = 0
#   while zero_array_counter >= zero_array.length
#     y,x = zero_array[zero_array_counter]

    possible = (1..9).to_a
    possible.delete_if{|value| row_final[y].include? value}
    possible.delete_if{|value| col_final[x].include? value}
    zero_array_counter+=1

end
#find zero's in the string
#give zero's a value [1,2,3,4,5,6,7,8,9]
#lopo through



  def board
      @board_string = @board_string.to_s.split(//).each_slice(9).to_a.map!{|array| array.map!{|string| string.to_i}}

  end

  def to_s


      end
end

 q0 = [[0,0], [0,1], [0,2],
       [1,0], [1,1], [1,2],
       [2,0], [2,1], [2,2]]

 q1 = [[0,3], [0,4], [0,5],
       [1,3], [1,4], [1,5],
       [2,3], [2,4], [2,5]]

 q2 = [[0,6], [0,7], [0,8],
       [1,6], [1,7], [1,8],
       [2,6], [2,7], [2,8]]

 q3 = [[3,0], [3,1], [3,2],
       [4,0], [4,1], [4,2],
       [5,0], [5,1], [5,2]]

 q4 = [[3,3], [3,4], [3,5],
       [4,3], [4,4], [4,5],
       [5,3], [5,4], [5,5]]

 q5 = [[3,6], [3,7], [3,8],
       [4,6], [4,7], [4,8],
       [5,6], [5,7], [5,8]]

 q6 = [[6,0], [6,1], [6,2],
       [7,0], [7,1], [7,2],
       [8,0], [8,1], [8,2]]

 q7 = [[6,3], [6,4], [6,5],
       [7,3], [7,4], [7,5],
       [8,3], [8,4], [8,5]]

 q8 = [[6,6], [6,7], [6,8],
       [7,6], [7,7], [7,8],
       [8,6], [8,7], [8,8]]

@quadrants = [q0, q1, q2, q3, q4, q5, q6, q7, q8]

# def check_quadrant([2,1])
#[2,1]
  # quadrants.each{ |quadrants| quadrants.each{|find| find.include?([2,1])} }

list = @quadrants.flatten(1)


  # quadrants.each do |square|
  #   square.each_with_index do |spot,index|
  #     if spot == [2,1]
  #       puts square[index]
  #     end
  #   end
  # end

# end


# a = "105802000090076405200400819019007306762083090000061050007600030430020501600308900"
# sudoku_array = a.split(//).each_slice(9).to_a
# p sudoku_array

sudoku_call_1 = Sudoku.new(105802000090076405200400819019007306762083090000061050007600030430020501600308900)
sudoku_call_1.board
# sudoku_call_1.solve!


#take the original string input
#create a new array for boxes. boxes represents whats in the quadrant
#boxes array is nine elements, one for each box
#based on the math from google, the original string gets placed in one of the boxes
#


