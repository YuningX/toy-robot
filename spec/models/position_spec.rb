# frozen_string_literal: true

RSpec.describe Position, type: :model do
  describe '#create' do
    it 'should raise error if no valid position' do
      expect { Position.new }.to raise_error
      expect { Position.new(position_x: 'test', position_y: true) }.to raise_error
      expect { Position.new(position_x: 'test', position_y: 1) }.to raise_error
    end

    it 'should create successful' do
      position = Position.new(position_x: 1, position_y: '2')
      expect(position.position_x).to eq 1
      expect(position.position_y).to eq 2
    end
  end
end
