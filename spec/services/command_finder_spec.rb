RSpec.describe CommandFinder do
  describe '#get_instance_from_input' do
    it 'should raise error if input is not string' do
      expect { CommandFinder.get_instance_from_input }.to raise_error(ArgumentError)
      expect { CommandFinder.get_instance_from_input(1) }.to raise_error(ArgumentError)
    end

    it 'should return corresponding instance' do
      command = CommandFinder.get_instance_from_input(' LEFT')
      expect(command.original_command).to eq 'LEFT'
      expect(command.class.name).to eq 'Commands::Left'
      command = CommandFinder.get_instance_from_input('PLACE 1,2,NORTH')
      expect(command.original_command).to eq 'PLACE 1,2,NORTH'
      expect(command.class.name).to eq 'Commands::Place'
    end

    it 'should return error if input not correct' do
      expect { CommandFinder.get_instance_from_input('LEFTXXX') }.to raise_error(ArgumentError)
      expect { CommandFinder.get_instance_from_input('WRONG') }.to raise_error(ArgumentError)
    end
  end
end
