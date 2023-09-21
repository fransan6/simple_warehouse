class Crate
  attr_reader :position_x, :position_y, :width, :height, :product_code

  def initialize(position_x, position_y, width, height, product_code)
    @position_x = position_x
    @position_y = position_y
    @width = width
    @height = height
    @product_code = product_code
  end

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
