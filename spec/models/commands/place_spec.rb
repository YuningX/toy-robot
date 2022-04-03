# frozen_string_literal: true

RSpec.describe Commands::Place, type: :model do
  describe '#create' do
    it 'should raise error if not pass validation' do
      expect { Commands::Place.new(original_command: nil) }.to raise_error
      expect { Commands::Place.new(original_command: 'RIGHT') }.to raise_error
      expect { Commands::Place.new(original_command: 'TEST') }.to raise_error
      expect { Commands::Place.new(original_command: 'PLACE') }.to raise_error
      expect { Commands::Place.new(original_command: 'PLACE 1,2') }.to raise_error
      expect { Commands::Place.new(original_command: 'PLACE 1,2,TEST') }.to raise_error
    end

    it 'should create successful if original_command is in valid commands' do
      expect { Commands::Place.new(original_command: 'PLACE 1,2,NORTH') }.to_not raise_error(ArgumentError)
    end
  end

  describe '#run' do
    it 'should raise error if no valid robot' do
      robot = double('Robot')
      allow(robot).to receive(:is_a?).with(Robot).and_return(false)
      command = Commands::Place.new(original_command: 'PLACE 1,2,NORTH')
      expect { command.run(robot: robot) }.to raise_error(ArgumentError)
    end

    it 'should trigger the robot left action' do
      robot = double('Robot')
      allow(robot).to receive(:is_a?).with(Robot).and_return(true)
      command = Commands::Place.new(original_command: 'PLACE 1,2,NORTH')
      expect(robot).to receive(:place).with(position_x: '1', position_y: '2', direction: 'NORTH').and_return(nil)
      expect { command.run(robot: robot) }.to_not raise_error(ArgumentError)
    end
  end
end
