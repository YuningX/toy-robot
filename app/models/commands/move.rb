module Commands
  class Move < Commands::Base
    def run(**args)
      validate_command

      @robot = args[:robot]

      raise ArgumentError, "robot cannot be nil" if @robot.nil?

      @robot.move
    end
    
    private

    def validate_command
      raise ArgumentError, "Command is invalid" unless @original_command == "MOVE"
    end
  end
end