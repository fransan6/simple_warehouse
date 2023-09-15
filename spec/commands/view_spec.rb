require 'spec_helper'
require 'commands/view'

describe View do
  let(:unit) { Warehouse.new }
  let(:view) { described_class.new(unit) }

  describe '.command' do
    subject { described_class.command }
    it { is_expected.to eq 'view' }
  end

  describe '#execute' do
    it 'user receives a message if there is no user-created warehouse' do
      result = view.execute([])
      expect(result).to eq "> You have not yet created a warehouse. Please type `init W H`, with W being a number that represents the width and H being a number that represents the height."
    end

    it 'shows the warehouse' do
      unit.init(3, 2)
      result = view.execute([])
      expect(result).to eq(" . . .\n . . .")
    end
  end
end
