# frozen_string_literal: true

RSpec.describe DirectionFinder do
  describe '#get_instance_from_input' do
    it 'should raise error if input is invalid' do
      expect { DirectionFinder.get_instance_from_input }.to raise_error(ArgumentError)
      expect { DirectionFinder.get_instance_from_input(1) }.to raise_error(ArgumentError)
    end

    it 'should return corresponding instance' do
      direction = DirectionFinder.get_instance_from_input('NORTH')
      expect(direction.to_command).to eq 'NORTH'
      expect(direction.class.name).to eq 'Directions::North'
      direction = DirectionFinder.get_instance_from_input('SOUTH')
      expect(direction.to_command).to eq 'SOUTH'
      expect(direction.class.name).to eq 'Directions::South'
    end

    it 'should return error if input not correct' do
      expect { DirectionFinder.get_instance_from_input('MID') }.to raise_error(ArgumentError)
      expect { DirectionFinder.get_instance_from_input('WRONG') }.to raise_error(ArgumentError)
    end
  end
end
