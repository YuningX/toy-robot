module Commands
  class Right < Commands::Base
    def run(**args)
      validate_command

      @robot = args[:robot]

      raise ArgumentError, "robot cannot be nil" if @robot.nil?

      @robot.right
    end
    
    private

    def validate_command
      raise ArgumentError, "Command is invalid" unless @original_command == "RIGHT"
    end
  end
end