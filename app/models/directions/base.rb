module Directions
  class Base < ModelBase
    VALID_DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST'].freeze
    
    attr_reader :command_text

    validates! :command_text, inclusion: { in: VALID_DIRECTIONS }, presence: true

    def self.get_instance_from_input(input)
      raise ArgumentError, "input is invalid" unless input.is_a? String

      direction = case input
                  when 'NORTH'
                    Directions::North.new(command_text: input)
                  when 'EAST'
                    Directions::East.new(command_text: input)
                  when 'SOUTH'
                    Directions::South.new(command_text: input)
                  when 'WEST'
                    Directions::West.new(command_text: input)
                  else
                    raise ArgumentError, "Wrong Input"
                  end
      direction
    end

    def initialize(**args)
      @command_text = args[:command_text]
    end
    
    def left_direction
      raise StandardError, "left_direction is not implemented"
    end

    def right_direction
      raise StandardError, "right_direction is not implemented"
    end

    def get_next_position(**args)
      raise StandardError, "get_next_position is not implemented"
    end

  end
end