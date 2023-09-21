class Warehouse
  attr_reader :width, :height, :grid

  def initialize
    @width = nil
    @height = nil
    @grid = []
    @crates = []
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
      add_crate(crate)
      true
    else
      false
    end
  end

  def locate_crate_coordinates(product_code)
    crate = find_crate(product_code)
    obtain_crate_coordinates(crate)
  end

  private

  # methods for crate placement, with validations
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

  def add_crate(crate)
    @crates << crate
  end

  # methods for locating a crate
  def find_crate(product_code)
    @crates.find { |crate| crate.product_code == product_code }
  end

  def obtain_crate_coordinates(crate)
    locations = []
    (crate.position_y...crate.position_y + crate.height).each do |row|
      (crate.position_x...crate.position_x + crate.width).each do |col|
        locations << "(#{row},#{col})"
      end
    end
    '> Crate coordinates as (X,Y): ' + locations.join(' ') + '.'
  end
end
