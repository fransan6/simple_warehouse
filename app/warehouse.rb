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
    positions = {
      start_y: crate.position_y - 1,
      start_x: crate.position_x - 1,
      end_y: crate.position_y + crate.height - 2,
      end_x: crate.position_x + crate.width - 2
    }

    if crate_can_be_placed?(crate, positions)
      place_crate(crate, positions)
      true
    else
      false
    end
  end

  private

  def crate_overlaps_another_crate?(crate, positions)
    (positions[:start_y]..positions[:end_y]).each do |row|
      (positions[:start_x]..positions[:end_x]).each do |col|
        return false if @grid[row].nil? || @grid[col].nil? ||
        @grid.flatten.include?(" #{crate.product_code}") ||
        @grid[row][col] != " ."
      end
    end
    true
  end

  def crate_fit_within_boundaries?(crate, positions)
    return false if crate.width > @width || crate.height > @height ||
    positions[:start_x] > @width || positions[:end_x] > @width ||
    positions[:start_y] > @height || positions[:end_y] > @height
    true
  end

  def crate_can_be_placed?(crate, positions)
    crate_overlaps_another_crate?(crate, positions) &&
    crate_fit_within_boundaries?(crate, positions)
  end

  def place_crate(crate, positions)
    (positions[:start_y]..positions[:end_y]).each do |row|
      (positions[:start_x]..positions[:end_x]).each do |col|
        @grid[row][col] = " #{crate.product_code}"
      end
    end
  end
end
