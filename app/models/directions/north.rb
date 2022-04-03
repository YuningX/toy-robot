module Directions
  class North < Directions::Base
    def get_next_position(current_position: nil)
      raise ArgumentError, "current position is nil" if current_position.nil?
      next_position = Position.new(position_x: current_position.position_x, position_y: current_position.position_y + 1)
    end
    
    def left_direction
      Directions::Base.get_instance_from_input('WEST')
    end
    
    def right_direction
      Directions::Base.get_instance_from_input('EAST')
    end
  end
end