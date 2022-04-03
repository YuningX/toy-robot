# frozen_string_literal: true

module Simulators
  class CommandSimulator < Simulators::Base
    def run
      puts 'Command Simulator start!'
      loop do
        print '> '
        command = $stdin.gets.chomp
        process_command(command)
      end
    end
  end
end
