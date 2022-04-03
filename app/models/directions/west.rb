module Directions
  class West < Directions::Base
    def get_next_position(current_position: nil)
      raise ArgumentError, "current position is nil" if current_position.nil?
      next_position = Position.new(position_x: current_position.position_x - 1, position_y: current_position.position_y)
    end
    
    def left_direction
      Directions::Base.get_instance_from_input('SOUTH')
    end
    
    def right_direction
      Directions::Base.get_instance_from_input('NORTH')
    end
  end
end