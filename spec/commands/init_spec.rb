require 'spec_helper'
require 'commands/init'

describe Init do
  let(:unit) { Warehouse.new }
  let(:init) { described_class.new(unit) }

  def created_warehouse(width, height)
    expect(unit.grid).not_to be_empty
    expect(unit.grid.count).to eq(height)
    expect(unit.grid[0].count).to eq(width)
  end

  describe '.command' do
    subject { described_class.command }
    it { is_expected.to eq 'init' }
  end

  describe '#execute' do
    context 'when a user has not yet created their warehouse' do
      it 'a warehouse is created with the provided dimensions' do
        result = init.execute(['4', '3'])
        created_warehouse(4, 3)
        expect(result).to eq "> Warehouse created (4 x 3)."
      end
    end
  end

  context 'when a warehouse has already been created by the user' do
    before(:each) do
      init.execute(['5', '4'])
    end

    it 'a new warehouse is created with new dimensions if the user confirms `y`' do
      allow(init).to receive(:gets).and_return('y')
      result = init.execute(['6', '7'])
      created_warehouse(6, 7)
      expect(result).to eq "> Warehouse created (6 x 7)."
    end

    it 'no new warehouse is created if the user confirms `n`' do
      allow(init).to receive(:gets).and_return('n')
      result = init.execute(['6', '7'])
      expect(result).to eq "> No warehouse created - current warehouse retained (5 x 4). Type `help` for instructions on usage."
    end
  end
end
