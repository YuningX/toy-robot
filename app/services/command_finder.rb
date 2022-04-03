# frozen_string_literal: true

class CommandFinder
  def self.get_instance_from_input(input)
    raise ArgumentError, 'input is invalid' unless input.is_a? String

    input.strip!
    primary_command = input.split(' ').first

    case primary_command
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
      raise ArgumentError, 'Invalid command'
    end
  end
end
