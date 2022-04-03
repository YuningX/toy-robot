module Commands
  class Move < Commands::Base
    def run(**args)
      @robot = args[:robot]

      raise ArgumentError, 'robot is invalid' unless @robot.is_a? Robot

      @robot.move
    end

    private

    def validate_command
      raise ArgumentError, 'Command is invalid' unless @original_command == 'MOVE'
    end
  end
end
