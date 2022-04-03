module Commands
  class Place < Commands::Base
    def run(**args)
      @robot = args[:robot]

      raise ArgumentError, 'robot is invalid' unless @robot.is_a? Robot

      params = retrieve_params
      @robot.place(position_x: params[0], position_y: params[1], direction: params[2])
    end

    private

    def retrieve_params
      params_command = @original_command.split(' ').last
      params_command.split(',')
    end

    def validate_command
      unless @original_command.match(/(PLACE) (\d),(\d),(NORTH|SOUTH|EAST|WEST)/)
        raise ArgumentError,
              'Command is invalid'
      end
    end
  end
end
