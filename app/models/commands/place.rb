module Commands
  class Place < Commands::Base
    def run(**args)
      @robot = args[:robot]

      raise ArgumentError, "robot cannot be nil" if @robot.nil?

      params = retrieve_params

      @robot.place(position_x: params[0], position_y: params[1], direction: params[2])
    end
    
    private

    def retrieve_params
      validate_command
      params_command = @original_command.split(' ').last
      params_command.split(',')
    end

    def validate_command
      raise ArgumentError, "Command is invalid" unless @original_command.match(/(PLACE) (\d),(\d),(NORTH|SOUTH|EAST|WEST)/)
    end

  end
end