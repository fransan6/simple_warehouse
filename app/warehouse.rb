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
end
