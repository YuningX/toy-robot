# frozen_string_literal: true

RSpec.describe Simulators::CommandSimulator do
  describe '#run' do
    it 'should run correct command' do
      simulator = Simulators::CommandSimulator.new
      allow(simulator).to receive(:loop).and_yield
      allow($stdin).to receive(:gets) { 'PLACE 1,2,NORTH' }
      simulator.run
      expect(simulator.robot.placed?).to eq true
      expect(simulator.robot.position.position_x).to eq 1
      expect(simulator.robot.position.position_y).to eq 2
      expect(simulator.robot.current_direction).to eq DirectionFinder.get_instance_from_input('NORTH')
    end

    it 'should ignore error command' do
      simulator = Simulators::CommandSimulator.new
      allow(simulator).to receive(:loop).and_yield
      allow($stdin).to receive(:gets) { 'PLACE 1,2,' }
      simulator.run
      expect(simulator.robot.placed?).to eq false
    end
  end
end
