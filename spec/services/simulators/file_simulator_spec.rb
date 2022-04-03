# frozen_string_literal: true

RSpec.describe Simulators::FileSimulator do
  describe '#create' do
    it 'should create a new Simulator with default tabletop and robot' do
      simulator = Simulators::FileSimulator.new(file_path: '/test')
      expect(simulator.tabletop).to be_present
      expect(simulator.tabletop.start_x).to eq 0
      expect(simulator.tabletop.start_y).to eq 0
      expect(simulator.tabletop.end_x).to eq 4
      expect(simulator.tabletop.end_y).to eq 4
      expect(simulator.instance_variable_get(:@file_path)).to eq '/test'
      expect(simulator.robot).to be_present
      expect(simulator.robot.placed?).to eq false
      expect(simulator.robot.current_tabletop).to eq simulator.tabletop
    end
  end

  describe '#run' do
    it 'should raise error if file_path is nil' do
      simulator = Simulators::FileSimulator.new(file_path: nil)
      expect { simulator.run }.to raise_error(ArgumentError)
    end

    it 'should run file with error command' do
      simulator = Simulators::FileSimulator.new(file_path: 'spec/fixtures/test_files/commands_with_errors.txt')
      expect do
        simulator.run
      end.to output("3,3,NORTH\n3,3,NORTH\n").to_stdout
    end

    it 'should run file without error command' do
      simulator = Simulators::FileSimulator.new(file_path: 'spec/fixtures/test_files/correct_commands.txt')
      expect do
        simulator.run
      end.to output("3,3,NORTH\n").to_stdout
    end
  end
end
