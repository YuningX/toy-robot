# frozen_string_literal: true

module Simulators
  class Base
    attr_reader :robot, :tabletop

    def initialize(**_args)
      @tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      @robot = Robot.new(current_tabletop: @tabletop)
    end

    def run
      raise StandardError, 'run is not implemented'
    end

    private

    def process_command(input)
      command = CommandFinder.get_instance_from_input(input)
      command.run(robot: @robot)
    rescue ArgumentError, StandardError, ActiveModel::StrictValidationFailed
    end
  end
end
