# frozen_string_literal: true

module Directions
  class Base < ModelBase
    include Singleton

    def left_direction
      raise StandardError, 'left_direction is not implemented'
    end

    def right_direction
      raise StandardError, 'right_direction is not implemented'
    end

    def get_next_position(**_args)
      raise StandardError, 'get_next_position is not implemented'
    end
  end
end
