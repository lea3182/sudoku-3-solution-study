class Sudoku
  attr_reader :board
  def initialize(board_string)
    #input_array = board_string.to_a
    # #length = @board_string.length
    @input_array = board_string.split("").map{|num| num.to_i}
    @board = Array.new(9) { @input_array.shift(9) }

    @base=(1..9).to_a

    #rows
    @row_0=@board[0]
    @row_1=@board[1]
    @row_2=@board[2]
    @row_3=@board[3]
    @row_4=@board[4]
    @row_5=@board[5]
    @row_6=@board[6]
    @row_7=@board[7]
    @row_8=@board[8]

    @rows=[@row_0,@row_1,@row_2,@row_3,@row_4,@row_5,@row_6,@row_7,@row_8]

    #columns
    @column_0=@board[0][0],@board[1][0],@board[2][0],@board[3][0],@board[4][0],@board[5][0],@board[6][0],@board[7][0],@board[8][0]
    @column_1=@board[0][1],@board[1][1],@board[2][1],@board[3][1],@board[4][1],@board[5][1],@board[6][1],@board[7][1],@board[8][1]
    @column_2=@board[0][2],@board[1][2],@board[2][2],@board[3][2],@board[4][2],@board[5][2],@board[6][2],@board[7][2],@board[8][2]
    @column_3=@board[0][3],@board[1][3],@board[2][3],@board[3][3],@board[4][3],@board[5][3],@board[6][3],@board[7][3],@board[8][3]
    @column_4=@board[0][4],@board[1][4],@board[2][4],@board[3][4],@board[4][4],@board[5][4],@board[6][4],@board[7][4],@board[8][4]
    @column_5=@board[0][5],@board[1][5],@board[2][5],@board[3][5],@board[4][5],@board[5][5],@board[6][5],@board[7][5],@board[8][5]
    @column_6=@board[0][6],@board[1][6],@board[2][6],@board[3][6],@board[4][6],@board[5][6],@board[6][6],@board[7][6],@board[8][6]
    @column_7=@board[0][7],@board[1][7],@board[2][7],@board[3][7],@board[4][7],@board[5][7],@board[6][7],@board[7][7],@board[8][7]
    @column_8=@board[0][8],@board[1][8],@board[2][8],@board[3][8],@board[4][8],@board[5][8],@board[6][8],@board[7][8],@board[8][8]


    @columns=[@column_0,@column_1,@column_2,@column_3,@column_4,@column_5,@column_6,@column_7,@column_8]

    #squares
    @square_0=@board[0][0],@board[0][1],@board[0][2],@board[1][0],@board[1][1],@board[1][2],@board[2][0],@board[2][1],@board[2][2]
    @square_1=@board[0][3],@board[0][4],@board[0][5],@board[1][3],@board[1][4],@board[1][5],@board[2][3],@board[2][4],@board[2][5]
    @square_2=@board[0][6],@board[0][7],@board[0][8],@board[1][6],@board[1][7],@board[1][8],@board[2][6],@board[2][7],@board[2][8]

    @square_3=@board[3][0],@board[3][1],@board[3][2],@board[4][0],@board[4][1],@board[4][2],@board[5][0],@board[5][1],@board[5][2]
    @square_4=@board[3][3],@board[3][4],@board[3][5],@board[4][3],@board[4][4],@board[4][5],@board[5][3],@board[5][4],@board[5][5]
    @square_5=@board[3][6],@board[3][7],@board[3][8],@board[4][6],@board[4][7],@board[4][8],@board[5][6],@board[5][7],@board[5][8]

    @square_6=@board[6][0],@board[6][1],@board[6][2],@board[7][0],@board[7][1],@board[7][2],@board[8][0],@board[8][1],@board[8][2]
    @square_7=@board[6][3],@board[6][4],@board[6][5],@board[7][3],@board[7][4],@board[7][5],@board[8][3],@board[8][4],@board[8][5]
    @square_8=@board[6][6],@board[6][7],@board[6][8],@board[7][6],@board[7][7],@board[7][8],@board[8][6],@board[8][7],@board[8][8]

    @squares = [@square_0,@square_1,@square_2,@square_3,@square_4,@square_5,@square_6,@square_7,@square_8]

    ####inverted board
        #rows
    @inverted_column_0=@board[0]
    @inverted_column_1=@board[1]
    @inverted_column_2=@board[2]
    @inverted_column_3=@board[3]
    @inverted_column_4=@board[4]
    @inverted_column_5=@board[5]
    @inverted_column_6=@board[6]
    @inverted_column_7=@board[7]
    @inverted_column_8=@board[8]

    @inverted_rows=[@row_0,@row_1,@row_2,@row_3,@row_4,@row_5,@row_6,@row_7,@row_8]

    #columns
    @inverted_column_0=@board[0][0],@board[1][0],@board[2][0],@board[3][0],@board[4][0],@board[5][0],@board[6][0],@board[7][0],@board[8][0]
    @inverted_column_1=@board[0][1],@board[1][1],@board[2][1],@board[3][1],@board[4][1],@board[5][1],@board[6][1],@board[7][1],@board[8][1]
    @inverted_column_2=@board[0][2],@board[1][2],@board[2][2],@board[3][2],@board[4][2],@board[5][2],@board[6][2],@board[7][2],@board[8][2]
    @inverted_column_3=@board[0][3],@board[1][3],@board[2][3],@board[3][3],@board[4][3],@board[5][3],@board[6][3],@board[7][3],@board[8][3]
    @inverted_column_4=@board[0][4],@board[1][4],@board[2][4],@board[3][4],@board[4][4],@board[5][4],@board[6][4],@board[7][4],@board[8][4]
    @inverted_column_5=@board[0][5],@board[1][5],@board[2][5],@board[3][5],@board[4][5],@board[5][5],@board[6][5],@board[7][5],@board[8][5]
    @inverted_column_6=@board[0][6],@board[1][6],@board[2][6],@board[3][6],@board[4][6],@board[5][6],@board[6][6],@board[7][6],@board[8][6]
    @inverted_column_7=@board[0][7],@board[1][7],@board[2][7],@board[3][7],@board[4][7],@board[5][7],@board[6][7],@board[7][7],@board[8][7]
    @inverted_column_8=@board[0][8],@board[1][8],@board[2][8],@board[3][8],@board[4][8],@board[5][8],@board[6][8],@board[7][8],@board[8][8]


    @inverted_columns=[@column_0,@column_1,@column_2,@column_3,@column_4,@column_5,@column_6,@column_7,@column_8]

    #squares
    @inverted_square_0=@board[0][0],@board[0][1],@board[0][2],@board[1][0],@board[1][1],@board[1][2],@board[2][0],@board[2][1],@board[2][2]
    @inverted_square_1=@board[0][3],@board[0][4],@board[0][5],@board[1][3],@board[1][4],@board[1][5],@board[2][3],@board[2][4],@board[2][5]
    @inverted_square_2=@board[0][6],@board[0][7],@board[0][8],@board[1][6],@board[1][7],@board[1][8],@board[2][6],@board[2][7],@board[2][8]

    @inverted_square_3=@board[3][0],@board[3][1],@board[3][2],@board[4][0],@board[4][1],@board[4][2],@board[5][0],@board[5][1],@board[5][2]
    @inverted_square_4=@board[3][3],@board[3][4],@board[3][5],@board[4][3],@board[4][4],@board[4][5],@board[5][3],@board[5][4],@board[5][5]
    @inverted_square_5=@board[3][6],@board[3][7],@board[3][8],@board[4][6],@board[4][7],@board[4][8],@board[5][6],@board[5][7],@board[5][8]

    @inverted_square_6=@board[6][0],@board[6][1],@board[6][2],@board[7][0],@board[7][1],@board[7][2],@board[8][0],@board[8][1],@board[8][2]
    @inverted_square_7=@board[6][3],@board[6][4],@board[6][5],@board[7][3],@board[7][4],@board[7][5],@board[8][3],@board[8][4],@board[8][5]
    @inverted_square_8=@board[6][6],@board[6][7],@board[6][8],@board[7][6],@board[7][7],@board[7][8],@board[8][6],@board[8][7],@board[8][8]

    @inverted_squares = [@square_0,@square_1,@square_2,@square_3,@square_4,@square_5,@square_6,@square_7,@square_8]
  end











  def solve!
    p "Original Board"
    print_the_board

    p "Availability Board"
    check_all_availabilty
    print_the_board
    p "Reduced Board by rows"
    reduce_grid_rows
    print_the_board
    p "Reduced Board by columns"
    reduce_grid_columns
    print_the_board

    # p @board


    # if @board.flatten.count == 81
    #   return @board
    # else
    #    solve!
    # end


    #p @board
    #check_all_availabilty
    #p @board
    #reduce_grid
    #p @board
    #check_all_availabilty
    #p @board
    #solve!
     # if @board.flatten.count == 81
     #   return @board
     # else
     #  solve!
     # end

  end

  def invert_board(board)
      columns=[]
    board.length.times do |i|
      temp_array = []
      board.each do |row|
        temp_array << row[i]
      end
      columns << temp_array
    end
    return columns
  end


  def check_all_availabilty
    @rows.each{|row| reduce_single_arrays(row)}

    for i in (0..8)
      for j in (0..8)
        @board[i][j]
        if @board[i][j] == 0 or (@board[i][j]).is_a? Array
          #puts "I used to be zero"
          #puts @board[i][j] = check_availability(i,j)
          check_availability(i,j)
        else
          @board[i][j]
        end
      end
    end

    @rows.each do |row|
      row.each do |element|
        if element.is_a? Array
          if element.length==1
            check_all_availabilty
          end
        end
      end
    end
    return @board
  end

  def check_all_availabilty_inverted
    @rows.each{|row| reduce_single_arrays(row)}
    #print_the_board

    for i in (0..8)
      for j in (0..8)
        @board[i][j]
        if @board[i][j] == 0 or (@board[i][j]).is_a? Array
          #puts "I used to be zero"
          #puts @board[i][j] = check_availability(i,j)
          check_availability_inverted(i,j)
        else
          @board[i][j]
        end
      end
    end

    @rows.each do |row|
      row.each do |element|
        if element.is_a? Array
          if element.length==1
            check_all_availabilty
          end
        end
      end
    end
    return @board
  end
    #reduce_grid
       #@rows.map! {|row| reduce_availability(row)}
       #@columns.map! {|column| reduce_availability(column)}
       #@squares.map! {|square| reduce_availability(square)}

    #@board[0][1] = @base - @row_0 - @column_1 - @square_0

    #@board[i][j] = @base-@rows[i]-@columns[j]-@squares[check_square_index(i,j)]

    #reduce_availability()
    #p @board.flatten.count


   def reduce_grid_rows
     @rows
     @rows.map! {|row| reduce_availability(row)}

     @columns.map! {|column| reduce_availability(column)}
     #@squares.map! {|square| reduce_availability(square)}

     @rows.each do |row|
        row.map! do |element|
          if element.is_a? Array
            element=0
          else
            element
          end
        end
      end
    @board

     # #if @board.flatten.count == 81
     #  puts "hello"
     #  return @board
     # else
     #  #@board
     #  #puts "hello"
     #   check_all_availabilty
     # end
   end

  def reduce_grid_columns
    @board=invert_board(@board)
    p "inverted board"
    print_the_board
    p "Availability"
    check_all_availabilty_inverted
    #print_the_board
    @board.map! {|row| reduce_availability(row)}
    @board=invert_board(@board)
    return @board
  end


  def reduce_single_arrays(field)
      field.map! do |num|
        if num.is_a? Array
          if num.length==1
            num = num[0]
          else
            num
          end
        else
          num
        end
      end
      return field
  end
   #@columns.map! {|column| reduce_availability(column)}
   # #@rows.map! {|row| reduce_availability(row)}
   # #@columns.map! {|column| reduce_availability(column)}
   # #@squares.map! {|square| reduce_availability(square)}

   #   @rows.each do |row|
   #      row.map! do |element|
   #        if element.is_a? Array
   #          element=0
   #        else
   #          element
   #        end
   #      end
   #    end
   #  @board

   # #if @board.flatten.count == 81
   #  puts "hello"
   #  return @board
   # else
   #  #@board
   #  #puts "hello"
   #   check_all_availabilty
   # end



  def board
    @board.map{|row| row.join("|") + "\n" +"-----------------"+"\n"}.join
  end

  def print_the_board
    @board.each_with_index{ |row, index | print "Row #{index+1}: " ; print row; print "\n"}
  end

  def check_availability(i,j)

    @check_rows=[]

    @rows[i].each{|num| @check_rows << num if num.is_a? Integer}

    @check_columns=[]
    #@column_board[j].each{|num| @check_columns << num if num.is_a? Integer}
    @columns[j].each{|num| @check_columns << num if num.is_a? Integer}


    @check_squares=[]
    #{}"I'm the square index: #{check_square_index(i,j)}"
    @squares[check_square_index(i,j)].each {|num| @check_squares << num if num.is_a? Integer}
    @check_squares


    @board[i][j] = @base-@check_rows-@check_columns-@check_squares
  end

  def check_availability_inverted(i,j)
    #print_the_board
    #p "this is where i am"
    #p create_columns(@board)


    #p i; p j
    @check_rows=[]
    #p @columns
    @columns[i].each{|num| @check_rows << num if num.is_a? Integer}
    #p @check_rows
    @check_columns=[]
    #@column_board[j].each{|num| @check_columns << num if num.is_a? Integer}
    @rows[j].each{|num| @check_columns << num if num.is_a? Integer}
    #p @check_columns

    @check_squares=[]
    #"I'm the square index: #{check_square_index(i,j)}"
    @squares[check_square_index(i,j)].each {|num| @check_squares << num if num.is_a? Integer}
    #p @check_squares


    @board[i][j] = @base-@check_rows-@check_columns-@check_squares
  end

  def check_square_index(i,j)
      case
        when (0..2).include?(i) && (0..2).include?(j)
          return 0
        when (0..2).include?(i) && (3..5).include?(j)
          return 1
        when (0..2).include?(i) && (6..8).include?(j)
          return 2
        when (3..5).include?(i) && (0..2).include?(j)
          return 3
        when (3..5).include?(i) && (3..5).include?(j)
          return 4
        when (3..5).include?(i) && (6..8).include?(j)
          return 5
        when (6..8).include?(i) && (0..2).include?(j)
          return 6
        when (6..8).include?(i) && (3..5).include?(j)
          return 7
        when (6..8).include?(i) && (6..8).include?(j)
          return 8
      end
  end


  def reduce_availability(field)
    reduce_single_arrays(field)
      # field.map! do |element|
      #   if element.is_a? Array
      #     if element.length==1
      #       element = element[0]
      #     else
      #       element
      #     end
      #   else
      #     element
      #   end
      # end

      array_of_possibilities=[]
      field.each {|element| array_of_possibilities << element if element.is_a? Array}

      unique_num = array_of_possibilities.flatten.select{|number| array_of_possibilities.flatten.count(number)==1}

      return field if unique_num.empty?

      unique_num.each do |unique|
        field.map! do |element|
          if element.is_a? Array
            if element.include?(unique)
              element=unique
            else
              element
            end
          else
          element
          end
        end
      end


    reduce_availability(field)


  end

  def create_columns(board)
      columns=[]
    board.length.times do |i|
      temp_array = []
      board.each do |row|
        temp_array << row[i]
      end

      columns << temp_array

    end
    return columns
  end



end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"

game.solve!

#print game.board

#puts game.board_string