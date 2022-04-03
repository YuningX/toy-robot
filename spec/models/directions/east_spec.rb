# frozen_string_literal: true

RSpec.describe Directions::East, type: :model do
  describe '#get_next_position' do
    it 'should raise error if no valid current position' do
      east = Directions::East.instance
      expect { east.get_next_position(current_position: nil) }.to raise_error
    end

    it 'should return the next position in this direction' do
      position = Position.new(position_x: 0, position_y: 0)
      east = Directions::East.instance
      new_position = east.get_next_position(current_position: position)
      expect(new_position.position_x).to eq position.position_x + 1
      expect(new_position.position_y).to eq position.position_y
    end
  end

  describe '#left_direction' do
    it 'should return the left direction' do
      east = Directions::East.instance
      expect(east.left_direction).to eq DirectionFinder.get_instance_from_input('NORTH')
    end
  end

  describe '#right_direction' do
    it 'should return the right direction' do
      east = Directions::East.instance
      expect(east.right_direction).to eq DirectionFinder.get_instance_from_input('SOUTH')
    end
  end

  describe '#to_command' do
    it 'should return the command' do
      east = Directions::East.instance
      expect(east.to_command).to eq 'EAST'
    end
  end
end
