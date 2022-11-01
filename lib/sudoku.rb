class Sudoku
  SUB_GROUP_INDEXES =
    [
      [0, 0], [0, 3], [0, 6],
      [3, 0], [3, 3], [3, 6],
      [6, 0], [6, 3], [6, 6]
    ]

  def initialize(sudoku_string)
    @sudoku_string = sudoku_string
    @sudoku_data = extract_sudoku_data(sudoku_string)
  end

  def valid?
    rows_valid? && columns_valid? && subgroups_valid? && numbers_valid?
  end

  def completed?
    !@sudoku_string.include?('0')
  end

  private

  def extract_sudoku_data(sudoku_string)
    sudoku_string.tr('^0-9', '').chars.each_slice(9).map(&:join)
  end

  def numbers_valid?
    @sudoku_data.length == 9
  end

  def rows_valid?
    @sudoku_data.each do |row| 
      return false unless group_valid?(row)
    end

    return true
  end

  def columns_valid?
    for i in 0..8
      column = ''

      for j in 0..8
        column.concat(@sudoku_data[j][i])
      end

      return false unless group_valid?(column)
    end
    
    return true
  end
  
  def subgroups_valid?
    SUB_GROUP_INDEXES.each { |index| 
      group_row = index[0]
      group = ''

      for i in 0..2
        group.concat(@sudoku_data[group_row][index[1] + i])
        group_row += 1
      end

      return false unless group_valid?(group)
    }

    return true
  end

  def group_valid?(group)
    group = group.tr('0', '')
    return group.chars.uniq.count == group.chars.count
  end
end