class Crate
  attr_reader :position_x, :position_y, :width, :height, :product_code

  def initialize(position_x, position_y, width, height, product_code)
    @position_x = position_x
    @position_y = position_y
    @width = width
    @height = height
    @product_code = product_code
  end
end
