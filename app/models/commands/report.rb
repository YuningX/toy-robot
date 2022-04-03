module Commands
  class Report < Commands::Base
    def run(**args)
      @robot = args[:robot]

      raise ArgumentError, 'robot is invalid' unless @robot.is_a? Robot

      @robot.report
    end

    private

    def validate_command
      raise ArgumentError, 'Command is invalid' unless @original_command == 'REPORT'
    end
  end
end
