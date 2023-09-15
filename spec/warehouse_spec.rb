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

  describe '#store?' do
    before do
      unit.init(4, 4)
    end

    it 'returns true when a crate can be stored' do
      crate = Crate.new(1, 1, 2, 2, 'R')
      expect(unit.store?(crate)).to be true
    end

    it 'returns false when a crate cannot fit inside the warehouse' do
      crate = Crate.new(1, 1, 3, 5, 'R')
      expect(unit.store?(crate)).to be false
    end

    it 'returns false when a crate goes out of bounds on the y-axis' do
      crate = Crate.new(4, 4, 2, 2, 'R')
      expect(unit.store?(crate)).to be false
    end

    it 'returns false when a crate goes out of bounds on the x-axis' do
      crate = Crate.new(4, 4, 2, 2, 'R')
      expect(unit.store?(crate)).to be false
    end

    it 'returns false when a crate overlaps with another crate' do
      crate1 = Crate.new(1, 1, 2, 2, 'R')
      crate2 = Crate.new(2, 2, 2, 2, 'A')
      unit.store?(crate1)
      expect(unit.store?(crate2)).to be false
    end
  end
end
