# frozen_string_literal: true

RSpec.describe Simulators::Base do
  describe '#create' do
    it 'should create a new Simulator with default tabletop and robot' do
      simulator = Simulators::Base.new
      expect(simulator.tabletop).to be_present
      expect(simulator.tabletop.start_x).to eq 0
      expect(simulator.tabletop.start_y).to eq 0
      expect(simulator.tabletop.end_x).to eq 4
      expect(simulator.tabletop.end_y).to eq 4
      expect(simulator.robot).to be_present
      expect(simulator.robot.placed?).to eq false
      expect(simulator.robot.current_tabletop).to eq simulator.tabletop
    end
  end
end
