# frozen_string_literal: true

module Directions
  class South < Directions::Base
    def get_next_position(current_position: nil)
      raise ArgumentError, 'current position is invalid' unless current_position.is_a? Position

      next_position = Position.new(position_x: current_position.position_x, position_y: current_position.position_y - 1)
    end

    def left_direction
      DirectionFinder.get_instance_from_input('EAST')
    end

    def right_direction
      DirectionFinder.get_instance_from_input('WEST')
    end

    def to_command
      'SOUTH'
    end
  end
end
