class Sudoku
  attr_accessor :board_string

  def initialize(board)
    @board_string = board
  end

  def gather_row(i)  #Works
    row_of_index, row_array = i/9, []
    for i in 0..8
      row_array << board_string[(row_of_index * 9) + i]
    end
    row_array
  end

  def gather_col(i)  #Works
    col_of_index, col_array = i%9, []
    for i in 0..8
      col_array << board_string[col_of_index + (i*9)]
    end
    col_array
  end

  def gather_square(i)  #There is a pattern in the case statement; rewrite later
    row_of_index, col_of_index = i/9, i%9
    indexes = []
    if row_of_index < 3 && col_of_index < 3
      indexes = [0,1,2,9,10,11,18,19,20]
    elsif row_of_index < 3 && (col_of_index > 2 && col_of_index < 6)
      indexes = [3,4,5,12,13,14,21,22,23]
    elsif row_of_index < 3 && (col_of_index > 5)
      indexes = [6,7,8,15,16,17,24,25,26]
    elsif (row_of_index >2 && row_of_index < 6) && col_of_index < 3
      indexes = [27,28,29,36,37,38,45,46,47]
    elsif (row_of_index >2 && row_of_index < 6) && (col_of_index > 2 && col_of_index < 6)
      indexes = [30,31,32,39,40,41,48,49,50]
    elsif (row_of_index >2 && row_of_index < 6) && (col_of_index > 5)
      indexes = [33,34,35,42,43,44,51,52,53]
    elsif (row_of_index > 5)  && col_of_index < 3
      indexes = [54,55,56,63,64,65,72,73,74]
    elsif (row_of_index > 5) && (col_of_index > 2 && col_of_index < 6)
      indexes = [57,58,59,66,67,68,75,76,77]
    elsif (row_of_index > 5) && (col_of_index > 5)
      indexes = [60,61,62,69,70,71,78,79,80]
    end
    values = []
    indexes.each{ |i| values << board_string[i] }
    return values
  end

  def single_nums?(array) # WORKS
    array.delete('-')
    return true if array == array.uniq
    false
  end

  def board_string_w(index,value)  #Works
    @board_string[index] = value.to_s
  end

  def valid?(i)  #Works
    return false if single_nums?(gather_row(i)) == false ||
                    single_nums?(gather_col(i)) == false ||
                    single_nums?(gather_square(i)) == false
    true
  end

  def view #Works; should be to_s
    for i in 0..80
      print @board_string[i] + " "
      puts "" if (i%9 == 8)
    end
  end

  def clear_screen!
    print "\e[2J"
  end

  def move_to_home!
    print "\e[H"
  end

  def reset_screen!
    clear_screen!
    move_to_home!
  end

  def solve
    num_of_loops = 0  #COUNTS NUMBER OF NUMBERS TESTED
    open_indices, stacks_for_open_indices = [], []

    for i in 0..80  #create an array of open idices and another array of stacks for each index
      if @board_string[i] == '-'
        open_indices << i
        stacks_for_open_indices << [9,8,7,6,5,4,3,2,1].shuffle! #shuffle optional; average performance boost
      end
    end

    counter = 0
    while true
      current_index = open_indices[counter]
      test_value = stacks_for_open_indices[counter].pop
      board_string_w(current_index,test_value) if test_value != nil  #prevents nil being placed on board, nil is returned when the stack is empty

      #This logic works but is difficult to read and has redundancies.  Logically identical but easier to read (and slower) logic is at the bottom of the file although it to would also benefit from being restructured.
      if (test_value != nil) && valid?(current_index)
        if (counter == open_indices.length - 1)
          puts " "
          puts "The Sudoku has a solution:"
          view()
          break
        else
          counter += 1
        end
      elsif (test_value == nil)
        if (counter > 0)
          board_string_w(current_index, '-')
          stacks_for_open_indices[counter] = [9,8,7,6,5,4,3,2,1].shuffle!
          counter -= 1
        else  #(test_value == nil) && (counter == 0)
          puts " "
          puts "The Sudoku has NO solution."
          break
        end
      else  #(test value != nil && current index is not valid), keep popping off stack
      end

            # #Enable next 4 lines if want to visualize the steps.
            # sleep(0.5)
            # reset_screen!()
            # puts "Sudoku Puzzle:"
            # view()
      num_of_loops += 1
      print ". " if num_of_loops % 100000 == 0
    end
    puts "Number of numbers tested:"
    puts num_of_loops
    return num_of_loops
  end

end   #end Sudoku class


#NEED TO PUT THE FOLLOWING FUNCTIONALITY INTO THE RUNNERL:

puzzle1  = '1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--'
puzzle2  = '--5-3--819-285--6-6----4-5---74-283-34976---5--83--49-15--87--2-9----6---26-495-3'
puzzle3  = '29-5----77-----4----4738-129-2--3-648---5--7-5---672--3-9--4--5----8-7---87--51-9'
puzzle4  = '-8--2-----4-5--32--2-3-9-466---9---4---64-5-1134-5-7--36---4--24-723-6-----7--45-'
puzzle5  = '6-873----2-----46-----6482--8---57-19--618--4-31----8-86-2---39-5----1--1--4562--'
puzzle6  = '---6891--8------2915------84-3----5-2----5----9-24-8-1-847--91-5------6--6-41----'
puzzle7  = '-3-5--8-45-42---1---8--9---79-8-61-3-----54---5------78-----7-2---7-46--61-3--5--'
puzzle8  = '-96-4---11---6---45-481-39---795--43-3--8----4-5-23-18-1-63--59-59-7-83---359---7'
puzzle9  = '----754----------8-8-19----3----1-6--------34----6817-2-4---6-39------2-53-2-----'
puzzle10 = '3---------5-7-3--8----28-7-7------43-----------39-41-54--3--8--1---4----968---2--'
puzzle11 = '3-26-9--55--73----------9-----94----------1-9----57-6---85----6--------3-19-82-4-'
puzzle12 = '-2-5----48-5--------48-9-2------5-73-9-----6-25-9------3-6-18--------4-71----4-9-'
puzzle13 = '--7--8------2---6-65--79----7----3-5-83---67-2-1----8----71--38-2---5------4--2--'
puzzle14 = '----------2-65-------18--4--9----6-4-3---57-------------------73------9----------'
puzzle15 = '---------------------------------------------------------------------------------'
puzzle_impossible = '11-------------------------------------------------------------------------------'
puzzle_new16 = "--57--6-8---436--96--8---31---548-9--94-----73-----465---9----695-----1-----21-54"


# SELECT PUZZLE AND SOLVE
game1 = Sudoku.new(puzzle11).solve
# game2 = Sudoku.new(puzzle12).solve



# #To study performance difference with/without #shuffle!
# loop_counts = []
# # while loop_counts.length < 10
#   sudoku1 = Sudoku.new(puzzle11)
#   var = sudoku1.solve
#   loop_counts << var
#   # loop_counts << Sudoku.new(puzzle11).solve
# # end
# p loop_counts.reduce(:+) / loop_counts.size




#EASIER TO READ LOGIC FOR SOLVE METHOD:
      # if (test_value != nil) && valid?(current_index) && (counter == open_indices.length - 1)
      #   puts " "
      #   puts "The Sudoku has a solution:"
      #   view()
      #   break
      # elsif (test_value != nil) && valid?(current_index) && (counter != open_indices.length - 1)
      #   counter += 1
      # elsif (test_value == nil) && (counter > 0)
      #   board_string_w(current_index, '-')
      #   stacks_for_open_indices[counter] = [9,8,7,6,5,4,3,2,1].shuffle!
      #   counter -= 1
      # elsif (test_value == nil) && (counter == 0)
      #   puts " "
      #   puts "The Sudoku has NO solution."
      #   break
      # else #(test value != nil && current index is not valid), keep popping off stack
      # end