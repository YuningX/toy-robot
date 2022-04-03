# frozen_string_literal: true

RSpec.describe Commands::Right, type: :model do
  describe '#create' do
    it 'should raise error if not pass validation' do
      expect { Commands::Right.new(original_command: nil) }.to raise_error
      expect { Commands::Right.new(original_command: 'LEFT') }.to raise_error
      expect { Commands::Right.new(original_command: 'TEST') }.to raise_error
    end

    it 'should create successful if original_command is in valid commands' do
      expect { Commands::Right.new(original_command: 'RIGHT') }.to_not raise_error(ArgumentError)
    end
  end

  describe '#run' do
    it 'should raise error if no valid robot' do
      robot = double('Robot')
      allow(robot).to receive(:is_a?).with(Robot).and_return(false)
      command = Commands::Right.new(original_command: 'RIGHT')
      expect { command.run(robot: robot) }.to raise_error(ArgumentError)
    end

    it 'should trigger the robot Right action' do
      robot = double('Robot')
      allow(robot).to receive(:is_a?).with(Robot).and_return(true)
      command = Commands::Right.new(original_command: 'RIGHT')
      expect(robot).to receive(:right).and_return(nil)
      expect { command.run(robot: robot) }.to_not raise_error(ArgumentError)
    end
  end
end
