# frozen_string_literal: true

module Directions
  class East < Directions::Base
    def get_next_position(current_position: nil)
      raise ArgumentError, 'current position is invalid' unless current_position.is_a? Position

      next_position = Position.new(position_x: current_position.position_x + 1, position_y: current_position.position_y)
    end

    def left_direction
      DirectionFinder.get_instance_from_input('NORTH')
    end

    def right_direction
      DirectionFinder.get_instance_from_input('SOUTH')
    end

    def to_command
      'EAST'
    end
  end
end
