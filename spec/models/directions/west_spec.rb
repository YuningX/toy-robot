# frozen_string_literal: true

RSpec.describe Directions::West, type: :model do
  describe '#get_next_position' do
    it 'should raise error if no valid current position' do
      west = Directions::West.instance
      expect { west.get_next_position(current_position: nil) }.to raise_error
    end

    it 'should return the next position in this direction' do
      position = Position.new(position_x: 0, position_y: 0)
      west = Directions::West.instance
      new_position = west.get_next_position(current_position: position)
      expect(new_position.position_x).to eq position.position_x - 1
      expect(new_position.position_y).to eq position.position_y
    end
  end

  describe '#left_direction' do
    it 'should return the left direction' do
      west = Directions::West.instance
      expect(west.left_direction).to eq DirectionFinder.get_instance_from_input('SOUTH')
    end
  end

  describe '#right_direction' do
    it 'should return the right direction' do
      west = Directions::West.instance
      expect(west.right_direction).to eq DirectionFinder.get_instance_from_input('NORTH')
    end
  end

  describe '#to_command' do
    it 'should return the command' do
      west = Directions::West.instance
      expect(west.to_command).to eq 'WEST'
    end
  end
end
