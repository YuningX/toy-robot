module Commands
  class Left < Commands::Base
    def run(**args)
      validate_command

      @robot = args[:robot]

      raise ArgumentError, "robot cannot be nil" if @robot.nil?

      @robot.left
    end
    
    private

    def validate_command
      raise ArgumentError, "Command is invalid" unless @original_command == "LEFT"
    end
  end
end