require 'spec_helper'
require 'commands/locate'

describe Locate do
  let(:unit) { Warehouse.new }
  let(:store) { Store.new(unit) }
  let(:init) { Init.new(unit) }
  let(:locate) { described_class.new(unit) }

  describe '.command' do
    subject { described_class.command }
    it { is_expected.to eq 'locate' }
  end

  describe '#execute' do
    context 'when the warehouse is not created yet' do
      it 'returns a message indicating no crates are found' do
        result = locate.execute(['R'])
        expect(result).to eq("> No crates found as you have not yet created a warehouse. Type `help` for instructions on usage.")
      end
    end

    context 'when the warehouse is created but empty' do
      it 'returns a message indicating no crates are found' do
        unit.init(3, 3)
        result = locate.execute(['R'])
        expect(result).to eq("> No crates found in the warehouse.")
      end
    end

    it 'locates all positions of a crate' do
      unit.init(5, 5)
      store.execute(['1', '1', '2', '3', 'R'])
      result = locate.execute(['R'])
      expect(result.split.length - 5).to eq(6)
    end

    it 'locates all positions of multiple crates with the same product code' do
      unit.init(10,10)
      store.execute(['1', '1', '2', '3', 'R'])
      store.execute(['4', '4', '2', '3', 'R'])
      result = locate.execute(['R'])
      expect(result.split.length - 5).to eq(12)
    end
  end
end
