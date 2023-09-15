class Warehouse
  attr_reader :width, :height, :grid

  def initialize
    @width = nil
    @height = nil
    @grid = []
  end

  def init(width, height)
    @width = width
    @height = height
    @grid = Array.new(height) { Array.new(width, " .") }
  end

  def store?(crate)
    start_y = crate.position_y - 1
    start_x = crate.position_x - 1
    end_y = crate.position_y + crate.height - 2
    end_x = crate.position_x + crate.width - 2

    if crate_can_be_placed?(crate, start_y, start_x, end_y, end_x)
      (start_y..end_y).each do |row|
        (start_x..end_x).each do |col|
          @grid[row][col] = " #{crate.product_code}"
        end
      end
      true
    else
      false
    end
  end

  private

  def crate_can_be_placed?(crate, start_y, start_x, end_y, end_x)
    (start_y..end_y).each do |row|
      (start_x..end_x).each do |col|
        return false if @grid[row].nil? || @grid[col].nil?
        return false if @grid.flatten.include?(" #{crate.product_code}") || @grid[row][col] != " ."
      end
    end

    if crate.width > @width || crate.height > @height
      false
    elsif start_x > @width || end_x > @width
      false
    elsif start_y > @height || end_y > @height
      false
    else
      true
    end
  end
end
