class Sudoku
  def initialize(board_string)
    @the_board = Board.new(board_string)
    # @board = board
    @board_string = board_string
  end

  def solve
    check_mini_board
    # check_row
    # check_col
    # rearrange_columns
  end

  def board
  end

  def set_board
    @the_board.create_mini_boards
    @the_board = @the_board.possibility_array_gen
  end

  def check_mini_board
    check_array = []
    counter = 0

    until counter == 9

     @the_board[counter].map do |miniboard|
      miniboard.each do |minirow|
        minirow.each do |cell|
          if minirow.length == 1
            check_array << minirow
          end
        end
      end
    end

    check_array = check_array.flatten
    @the_board[counter].map do |miniboard|
      miniboard.each do |minirow|
        minirow.each do |cell|
          if minirow.length > 1
            minirow.replace(minirow - check_array)
          end
        end
      end
    end

    check_array = []
    counter += 1
    end
    @the_board
  end

  def check_row

    all_rows_array = [

      #first row
      [ @the_board[0][0],
      @the_board[1][0],
      @the_board[2][0] ],

      # second row
      [ @the_board[0][1],
      @the_board[1][1],
      @the_board[2][1] ],

      # third row
      [ @the_board[0][2],
      @the_board[1][2],
      @the_board[2][2] ],

      # fourth row
      [ @the_board[3][0],
      @the_board[4][0],
      @the_board[5][0] ],

      # fifth_row
      [ @the_board[3][1],
      @the_board[4][1],
      @the_board[5][1] ],

      # sixth_row =
      [ @the_board[3][2],
      @the_board[4][2],
      @the_board[5][2] ],

      # seventh_row = [
      [ @the_board[6][0],
      @the_board[7][0],
      @the_board[8][0] ],

      # eighth_row =
      [ @the_board[6][1],
      @the_board[7][1],
      @the_board[8][1] ],

      # ninth_row =
      [ @the_board[6][2],
      @the_board[7][2],
      @the_board[8][2] ]

    ] # ends all_rows_array

    single_row_array = []
    counter = 0

    until counter == 9

      all_rows_array.each do |single_row|
        single_row.each do |minirow|
          minirow.each do |cell|
            if cell.length == 1
              single_row_array << cell
            end
          end
        end

        single_row_array = single_row_array.flatten
        all_rows_array[counter].each do |single_row|
          single_row.each do |minirow|
            minirow.each do |cell|
              if minirow.length > 1
                minirow.replace(minirow - single_row_array)
              end
            end
          end
        end
        # p single_row_array
        single_row_array = []
        counter += 1
      end
    end
    @the_board = all_rows_array
  end

  def check_col
   all_columns_array = [
      # column one
      [@the_board[0][0][0],
      @the_board[0][1][0],
      @the_board[0][2][0],
      @the_board[3][0][0],
      @the_board[3][1][0],
      @the_board[3][2][0],
      @the_board[6][0][0],
      @the_board[6][1][0],
      @the_board[6][2][0]
      ],

      # column two
      [ @the_board[0][0][1],
      @the_board[0][1][1],
      @the_board[0][2][1],
      @the_board[3][0][1],
      @the_board[3][1][1],
      @the_board[3][2][1],
      @the_board[6][0][1],
      @the_board[6][1][1],
      @the_board[6][2][1]
      ],

      # column three
      [ @the_board[0][0][2],
      @the_board[0][1][2],
      @the_board[0][2][2],
      @the_board[3][0][2],
      @the_board[3][1][2],
      @the_board[3][2][2],
      @the_board[6][0][2],
      @the_board[6][1][2],
      @the_board[6][2][2]
      ],

      # column four
      [ @the_board[1][0][0],
      @the_board[1][1][0],
      @the_board[1][2][0],
      @the_board[4][0][0],
      @the_board[4][1][0],
      @the_board[4][2][0],
      @the_board[7][0][0],
      @the_board[7][1][0],
      @the_board[7][2][0]
      ],

      # column five
      [ @the_board[1][0][1],
      @the_board[1][1][1],
      @the_board[1][2][1],
      @the_board[4][0][1],
      @the_board[4][1][1],
      @the_board[4][2][1],
      @the_board[7][0][1],
      @the_board[7][1][1],
      @the_board[7][2][1]
      ],

      # column six
      [ @the_board[1][0][2],
      @the_board[1][1][2],
      @the_board[1][2][2],
      @the_board[4][0][2],
      @the_board[4][1][2],
      @the_board[4][2][2],
      @the_board[7][0][2],
      @the_board[7][1][2],
      @the_board[7][2][2]
      ],

      # column seven
      [ @the_board[2][0][0],
      @the_board[2][1][0],
      @the_board[2][2][0],
      @the_board[5][0][0],
      @the_board[5][1][0],
      @the_board[5][2][0],
      @the_board[8][0][0],
      @the_board[8][1][0],
      @the_board[8][2][0]
      ],

      # column eight
      [ @the_board[2][0][1],
      @the_board[2][1][1],
      @the_board[2][2][1],
      @the_board[5][0][1],
      @the_board[5][1][1],
      @the_board[5][2][1],
      @the_board[8][0][1],
      @the_board[8][1][1],
      @the_board[8][2][1]
      ],

      # column nine
      [ @the_board[2][0][2],
      @the_board[2][1][2],
      @the_board[2][2][2],
      @the_board[5][0][2],
      @the_board[5][1][2],
      @the_board[5][2][2],
      @the_board[8][0][2],
      @the_board[8][1][2],
      @the_board[8][2][2] ]
  ]
  single_col_array = []
  counter = 0

  until counter == 9

    all_columns_array[counter].each do |cell|
        # single_col.each do |minirow|
        # single_col.each do |cell|
          if cell.length == 1
            single_col_array << cell
          end
          # p single_col_array
      end
      single_col_array = single_col_array.flatten
      all_columns_array[counter].each do |single_col|
        if single_col.length > 1
          single_col.replace(single_col - single_col_array)
        end
      end
      single_col_array = []
      counter += 1

    end
    all_columns_array
    # @the_board = all_columns_array
    # p @the_board

  # end

  # def rearrange_columns
    flat_array = all_columns_array.flatten(1)
     @the_board = [
          [flat_array[0],
           flat_array[9],
           flat_array[18],
           flat_array[27],
           flat_array[36],
           flat_array[45],
           flat_array[54],
           flat_array[63],
           flat_array[72]
         ],

          [flat_array[1],
           flat_array[10],
           flat_array[19],
           flat_array[28],
           flat_array[37],
           flat_array[46],
           flat_array[55],
           flat_array[64],
           flat_array[73]
          ],

          [flat_array[2],
           flat_array[11],
           flat_array[20],
           flat_array[29],
           flat_array[38],
           flat_array[47],
           flat_array[56],
           flat_array[65],
           flat_array[74]
         ],

           [flat_array[3],
           flat_array[12],
           flat_array[21],
           flat_array[30],
           flat_array[39],
           flat_array[48],
           flat_array[57],
           flat_array[66],
           flat_array[75]
         ],

          [flat_array[4],
           flat_array[13],
           flat_array[22],
           flat_array[31],
           flat_array[40],
           flat_array[49],
           flat_array[58],
           flat_array[67],
           flat_array[76]
         ],

          [flat_array[5],
           flat_array[14],
           flat_array[23],
           flat_array[32],
           flat_array[41],
           flat_array[50],
           flat_array[59],
           flat_array[68],
           flat_array[77]
         ],

          [flat_array[6],
           flat_array[15],
           flat_array[24],
           flat_array[33],
           flat_array[42],
           flat_array[51],
           flat_array[60],
           flat_array[69],
           flat_array[78]
         ],
          [flat_array[7],
           flat_array[16],
           flat_array[25],
           flat_array[34],
           flat_array[43],
           flat_array[52],
           flat_array[61],
           flat_array[70],
           flat_array[79]
         ],

          [flat_array[8],
           flat_array[17],
           flat_array[26],
           flat_array[35],
           flat_array[44],
           flat_array[53],
           flat_array[62],
           flat_array[71],
           flat_array[80]
         ]

       ]

       @the_board
  end

  def finished?
  end

  def solve_board
  end

  # Returns a string representing the current state of the board
  # to_s print the board
  def to_s
  end
end


class Board
  # getting all the rows, columns and boxes
  # have all the knowledge to set up the way it presents itself

  # 1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--
  def initialize(passed_string)
    @board_string = passed_string

  end

  def create_mini_boards
    new_array = @board_string.split("").each_slice(1).to_a
    # p new_array

    @mini_boards_1 = []
    @mini_boards_1 << new_array[0..2]
    @mini_boards_1 << new_array[9..11]
    @mini_boards_1 << new_array[18..20]

    @mini_boards_2 = []
    @mini_boards_2 << new_array[3..5]
    @mini_boards_2 << new_array[12..14]
    @mini_boards_2 << new_array[21..23]

    @mini_boards_3 = []
    @mini_boards_3 << new_array[6..8]
    @mini_boards_3 << new_array[15..17]
    @mini_boards_3 << new_array[24..26]

    @mini_boards_4 = []
    @mini_boards_4 << new_array[27..29]
    @mini_boards_4 << new_array[36..38]
    @mini_boards_4 << new_array[45..47]

    @mini_boards_5 = []
    @mini_boards_5 << new_array[30..32]
    @mini_boards_5 << new_array[39..41]
    @mini_boards_5 << new_array[48..50]

    @mini_boards_6 = []
    @mini_boards_6 << new_array[33..35]
    @mini_boards_6 << new_array[42..44]
    @mini_boards_6 << new_array[51..53]

    @mini_boards_7 = []
    @mini_boards_7 << new_array[54..56]
    @mini_boards_7 << new_array[63..65]
    @mini_boards_7 << new_array[72..74]

    @mini_boards_8 = []
    @mini_boards_8 << new_array[57..59]
    @mini_boards_8 << new_array[66..68]
    @mini_boards_8 << new_array[75..77]

    @mini_boards_9 = []
    @mini_boards_9 << new_array[60..62]
    @mini_boards_9 << new_array[69..71]
    @mini_boards_9 << new_array[78..80]

    @board = [@mini_boards_1, @mini_boards_2, @mini_boards_3, @mini_boards_4, @mini_boards_5, @mini_boards_6, @mini_boards_7, @mini_boards_8, @mini_boards_9 ]
    # @board.each { |mini| p mini }

  end

#FOR REFACTOR: possibilities array == variable "-"
def possibility_array_gen
  @board.each do |mini|
    mini.each do |minirow|
      minirow.map do |cell|
        if cell.include?("-")
          cell.replace([1,2,3,4,5,6,7,8,9])
        elsif cell[0].is_a? String
          cell[0] = cell[0].to_i
        end
      end
    end
  end
  @board
    # @board.each { |mini| p mini }
  end

end

# p game.board
# p game = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")

game = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")
game.set_board
# game.check_row
# p game.check_col
p game.solve
# game.rearrange_columns
# p game.check_mini_board
# game.create_mini_boards
# p game.possibility_array
