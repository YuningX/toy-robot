# frozen_string_literal: true

class DirectionFinder
  def self.get_instance_from_input(input)
    raise ArgumentError, 'input is invalid' unless input.is_a? String

    case input
    when 'NORTH'
      Directions::North.instance
    when 'EAST'
      Directions::East.instance
    when 'SOUTH'
      Directions::South.instance
    when 'WEST'
      Directions::West.instance
    else
      raise ArgumentError, 'Wrong Input'
    end
  end
end
