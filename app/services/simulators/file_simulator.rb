# frozen_string_literal: true

module Simulators
  class FileSimulator < Simulators::Base
    def initialize(**args)
      super
      @file_path = args[:file_path]
    end

    def run
      raise ArgumentError, 'File path is nil' if @file_path.nil?

      file = File.open(@file_path)

      file.readlines.each do |command|
        process_command(command)
      end
    end
  end
end
