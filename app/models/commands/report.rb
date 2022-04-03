module Commands
  class Report < Commands::Base
    def run(**args)
      validate_command

      @robot = args[:robot]

      raise ArgumentError, "robot cannot be nil" if @robot.nil?

      @robot.report
    end
    
    private

    def validate_command
      raise ArgumentError, "Command is invalid" unless @original_command == "REPORT"
    end
  end
end