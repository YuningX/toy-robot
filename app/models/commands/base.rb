module Commands
  class Base < ModelBase
    VALID_COMMANDS = %w[PLACE LEFT RIGHT MOVE REPORT].freeze
    
    attr_reader :original_command

    validates! :original_command, inclusion: VALID_COMMANDS, presence: true
    
    def self.get_instance_from_input(input)
      raise ArgumentError, "input is invalid" unless input.is_a? String
      input.strip!
      primary_command = input.split(" ").first

      command = case primary_command
                when 'PLACE'
                  Commands::Place.new(original_command: input)
                when 'MOVE'
                  Commands::Move.new(original_command: input)
                when 'LEFT'
                  Commands::Left.new(original_command: input)
                when 'RIGHT'
                  Command::Right.new(original_command: input)
                when 'REPORT'
                  Commands::Report.new(original_command: input)
                else
                  raise ArgumentError, "Invalid command"
                end
      command
    end

    def initialize(**args)
      @original_command = args[:original_command]
    end
    
    def run(**args)      
      raise StandardError, "process_command is not implemented"
    end
  end
end