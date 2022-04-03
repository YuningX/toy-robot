# frozen_string_literal: true

RSpec.describe Tabletop, type: :model do
  describe '#create' do
    it 'should raise error if no valid position' do
      expect { Tabletop.new(start_x: nil, start_y: nil, width: 1, height: 1) }.to raise_error
      expect { Tabletop.new(start_x: 'test', start_y: 'test', width: 1, height: 1) }.to raise_error
      expect { Tabletop.new(start_x: 2, start_y: 1, width: -1, height: 1) }.to raise_error
      expect { Tabletop.new(start_x: 2, start_y: 1) }.to raise_error
    end

    it 'should create successful' do
      tabletop = Tabletop.new(start_x: '1', start_y: '2', width: 1, height: '2')
      expect(tabletop.start_x).to eq 1
      expect(tabletop.start_y).to eq 2
      expect(tabletop.end_x).to eq 1
      expect(tabletop.end_y).to eq 3
    end
  end

  describe '#valid_position?' do
    it 'should return false if input not correct' do
      tabletop = Tabletop.new(start_x: '1', start_y: '2', width: 1, height: '2')
      expect(tabletop.valid_position?(nil)).to eq false
      expect(tabletop.valid_position?('test')).to eq false
    end

    it 'should return false if not in the correct position' do
      tabletop = Tabletop.new(start_x: '0', start_y: '0', width: 5, height: '5')
      position = Position.new(position_x: '0', position_y: '-1')
      expect(tabletop.valid_position?(position)).to eq false
      position = Position.new(position_x: '0', position_y: '5')
      expect(tabletop.valid_position?(position)).to eq false
      position = Position.new(position_x: '-1', position_y: '3')
      expect(tabletop.valid_position?(position)).to eq false
      position = Position.new(position_x: '5', position_y: '3')
      expect(tabletop.valid_position?(position)).to eq false
      position = Position.new(position_x: '-1', position_y: '-1')
      expect(tabletop.valid_position?(position)).to eq false
      position = Position.new(position_x: '5', position_y: '5')
      expect(tabletop.valid_position?(position)).to eq false
    end

    it 'should return true if the position is valid' do
      tabletop = Tabletop.new(start_x: '0', start_y: '0', width: 5, height: '5')
      position = Position.new(position_x: '0', position_y: '1')
      expect(tabletop.valid_position?(position)).to eq true
    end
  end
end
