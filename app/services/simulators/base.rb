module Simulators
  class Base
    attr_reader :robot, :tabletop

    def initialize(**args)
      @tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      @robot = Robot.new(current_tabletop: @tabletop)
    end

    def run
      raise StandardError, "run is not implemented"
    end

    def process_command(input)
      command = Commands::Base.get_instance_from_input(input)
      command.run(robot: @robot)
    end
  end
end