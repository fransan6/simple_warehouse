require 'spec_helper'
require 'warehouse'

describe Warehouse do
  let(:unit) { Warehouse.new }

  describe '#init' do
    it 'creates a warehouse with the provided width and height' do
      unit.init(3, 2)
      expect(unit.grid).not_to be_empty
      expect(unit.grid.flatten.all? { _1 == ' .' })
      expect(unit.grid.count).to eq(2)
      expect(unit.grid[0].count).to eq(3)
    end
  end

  describe '#initialize' do
    it 'instantiates a warehouse with no given dimensions' do
      expect(unit.grid).to be_empty
      expect(unit.width).to be_nil
      expect(unit.height).to be_nil
    end
  end
end
