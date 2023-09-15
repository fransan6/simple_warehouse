require 'spec_helper'
require 'commands/store'

describe Store do
  let(:unit) { Warehouse.new }
  let(:store) { described_class.new(unit) }

  describe '.command' do
    subject { described_class.command }
    it { is_expected.to eq 'store' }
  end

  describe '#execute' do
    before do
      unit.init(4, 4)
    end

    it 'stores a crate with given dimensions and product code at correct coordinates' do
      result = store.execute(['1', '1', '3', '2', 'R'])
      expect(unit.grid[0][0]).to eq ' R'
      expect(unit.grid[1][2]).to eq ' R'
      expect(unit.grid[3][3]).to eq ' .'
      expect(result).to eq "> Crate (3 x 2) successfully stored at (1,1)."
    end

    it "doesn't store a crate if it's too big for the warehouse" do
      result = store.execute(['1', '1', '3', '5', 'R'])
      expect(result).to eq "> Crate cannot be stored."
    end

    it "doesn't store a crate if it's out of bounds on the y-axis" do
      result = store.execute(['4', '4', '1', '2', 'R'])
      expect(result).to eq "> Crate cannot be stored."
    end

    it "doesn't store a crate if it's out of bounds on the x-axis" do
      result = store.execute(['4', '4', '2', '1', 'R'])
      expect(result).to eq "> Crate cannot be stored."
    end

    it "doesn't store a crate if it overlaps with another crate" do
      store.execute(['1', '1', '3', '2', 'R'])
      result = store.execute(['3', '2', '1', '1', 'R'])
      expect(result).to eq "> Crate cannot be stored."
    end

    it "doesn't store a crate the product code already exits" do
      store.execute(['1', '1', '1', '1', 'R'])
      result = store.execute(['3', '3', '1', '1', 'R'])
      expect(result).to eq "> Crate cannot be stored."
    end
  end
end
