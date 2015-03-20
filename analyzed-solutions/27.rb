class Sudoku

  def initialize(board_string)
    @board_string = board_string
    @board_hash = create_hash(board_string)
  end

  def solve!
    initial_solution = false
    until initial_solution
      initial_solution = true
      @board_hash.each do |k,v|
        if v["value"] == "0"
          house = check_house(k)
          row = check_row(k)
          col = check_col(k)
          not_possible = (house + row + col).uniq
          v["possible"] = v["possible"] - not_possible
          if v["possible"].length == 1
            initial_solution = false
            v["value"] = v["possible"][0]
          end
        end
      end
      @board_string = ""
      @board_hash.each_key{|k| @board_string << @board_hash[k]["value"]}
    end
  p "solved!"
  self.board
  end

  def check_row(index)
    row =[]
    row_hash = @board_hash.select{|k,v| v["row"] == index/9}
    row_hash.each{|k,v| row << v["value"]}
    row.delete("0")
    return row
  end

  def check_col(index)
    col = []
    col_hash = @board_hash.select{|k,v| v["col"] == index%9}
    col_hash.each{|k,v| col << v["value"]}
    col.delete("0")
    return col
  end

  def check_house(index)
    house = @board_hash[index]["house"]
    house_array = []
    house_hash = @board_hash.select{|k,v| v["house"] == house}
    house_hash.each{|k,v| house_array << v["value"]}
    house_array.delete("0")
    return house_array
  end

  def create_hash(string)
    hash = {}
    arr = string.split(//)
    arr.each_index do |i|
      hash[i] = Hash["row", i/9, "col", i%9, "value", arr[i]]
    end

    hash.each_key do |i|
      if (0..2).include?(i/9)
        if (0..2).include?(i%9)
          hash[i]["house"] = 'A'
        elsif (3..5).include?(i%9)
          hash[i]["house"] = 'B'
        else
          hash[i]["house"] = 'C'
        end
      elsif (3..5).include?(i/9)
        if (0..2).include?(i%9)
          hash[i]["house"] = 'D'
        elsif (3..5).include?(i%9)
          hash[i]["house"] = 'E'
        else
          hash[i]["house"] = 'F'
        end
      else
        if (0..2).include?(i%9)
          hash[i]["house"] = 'G'
        elsif (3..5).include?(i%9)
          hash[i]["house"] = 'H'
        else
          hash[i]["house"] = 'I'
        end
      end
      if hash[i]["value"] == "0"
        hash[i]["possible"] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      end
    end
    return hash
  end

  def board
    board_array = @board_string.split(//).each_slice(9).to_a
    board_array.each do |row|
      puts "|#{row[0]}  #{row[1]}  #{row[2]} | #{row[3]}  #{row[4]}  #{row[5]} | #{row[6]}  #{row[7]}  #{row[8]}|"
      puts "-"*28
    end

  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('set-02_project_euler_50-easy-puzzles.txt').first.chomp

game = Sudoku.new(board_string)

p @board_string
puts ""
# Remember: this will just fill out what it can and not "guess"
game.solve!

