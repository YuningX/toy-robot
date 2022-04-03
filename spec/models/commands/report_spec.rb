# frozen_string_literal: true

RSpec.describe Commands::Report, type: :model do
  describe '#create' do
    it 'should raise error if not pass validation' do
      expect { Commands::Report.new(original_command: nil) }.to raise_error
      expect { Commands::Report.new(original_command: 'RIGHT') }.to raise_error
      expect { Commands::Report.new(original_command: 'TEST') }.to raise_error
    end

    it 'should create successful if original_command is in valid commands' do
      expect { Commands::Report.new(original_command: 'REPORT') }.to_not raise_error(ArgumentError)
    end
  end

  describe '#run' do
    it 'should raise error if no valid robot' do
      robot = double('Robot')
      allow(robot).to receive(:is_a?).with(Robot).and_return(false)
      command = Commands::Report.new(original_command: 'REPORT')
      expect { command.run(robot: robot) }.to raise_error(ArgumentError)
    end

    it 'should trigger the robot left action' do
      robot = double('Robot')
      allow(robot).to receive(:is_a?).with(Robot).and_return(true)
      command = Commands::Report.new(original_command: 'REPORT')
      expect(robot).to receive(:report).and_return(nil)
      expect { command.run(robot: robot) }.to_not raise_error(ArgumentError)
    end
  end
end
