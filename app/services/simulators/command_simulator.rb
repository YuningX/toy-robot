module Simulators
  class CommandSimulator < Simulators::Base
    def run
      puts "Command Simulator start!"
      loop do
        print '> '
        command = STDIN.gets.chomp()
        begin
          process_command(command)
        rescue => e
          p e
        end
      end
    end
  end
end