module Simulators
  class FileSimulator < Simulators::Base
    def initialize(**args)
      super
      @file_path = args[:file_path]
    end
    
    def run
      if @file_path.nil?
        raise ArgumentError, "File path is nil"
      end

      file = File.open(@file_path)
      
      file.readlines.each do |command|
        begin
          process_command(command)
        rescue => e
          p e
        end
      end
    end
  end
end