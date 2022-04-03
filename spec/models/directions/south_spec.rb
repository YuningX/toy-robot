# frozen_string_literal: true

RSpec.describe Directions::South, type: :model do
  describe '#get_next_position' do
    it 'should raise error if no valid current position' do
      south = Directions::South.instance
      expect { south.get_next_position(current_position: nil) }.to raise_error
    end

    it 'should return the next position in this direction' do
      position = Position.new(position_x: 0, position_y: 0)
      south = Directions::South.instance
      new_position = south.get_next_position(current_position: position)
      expect(new_position.position_x).to eq position.position_x
      expect(new_position.position_y).to eq position.position_y - 1
    end
  end

  describe '#left_direction' do
    it 'should return the left direction' do
      south = Directions::South.instance
      expect(south.left_direction).to eq DirectionFinder.get_instance_from_input('EAST')
    end
  end

  describe '#right_direction' do
    it 'should return the right direction' do
      south = Directions::South.instance
      expect(south.right_direction).to eq DirectionFinder.get_instance_from_input('WEST')
    end
  end

  describe '#to_command' do
    it 'should return the command' do
      south = Directions::South.instance
      expect(south.to_command).to eq 'SOUTH'
    end
  end
end
