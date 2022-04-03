module Commands
  class Left < Commands::Base
    def run(**args)
      @robot = args[:robot]

      raise ArgumentError, 'robot is invalid' unless @robot.is_a? Robot

      @robot.left
    end

    private

    def validate_command
      raise ArgumentError, 'Command is invalid' unless @original_command == 'LEFT'
    end
  end
end
