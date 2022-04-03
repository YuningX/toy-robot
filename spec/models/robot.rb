# frozen_string_literal: true

RSpec.describe Robot, type: :model do
  describe '#create' do
    it 'creates a new robot' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      expect(robot.current_tabletop).to eq tabletop
    end

    it 'should raise error if no current tabletop' do
      expect { Robot.new(current_tabletop: nil) }.to raise_error
    end
  end

  describe '#placed?' do
    it 'should return true if have position and direction' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      expect(robot.placed?).to eq false
      robot.place(position_x: 1, position_y: 1, direction: 'NORTH')
      expect(robot.placed?).to eq true
    end

    it 'should return false if no position or direction' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      expect(robot.placed?).to eq false
    end
  end

  describe '#place' do
    it 'should raise error if position is invalid' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      expect(tabletop).to receive(:valid_position?).and_return(false)
      expect do
        robot.place(position_x: 1, position_y: 1,
                    direction: 'NORTH')
      end.to raise_error(ArgumentError, 'Position is not within the current tabletop')
    end

    it 'should raise error if direction is invalid' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      allow(DirectionFinder).to receive(:get_instance_from_input).and_return(nil)
      expect do
        robot.place(position_x: 1, position_y: 1, direction: 'NORTH')
      end.to raise_error(ArgumentError, 'Direction is invalid')
      expect(robot.position).to be_nil
      expect(robot.current_direction).to be_nil
    end

    it 'should place the robot successful' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      robot.place(position_x: 1, position_y: 1, direction: 'NORTH')
      expect(robot.placed?).to eq true
      expect(robot.position.position_x).to eq 1
      expect(robot.position.position_y).to eq 1
      expect(robot.current_direction).to eq DirectionFinder.get_instance_from_input('NORTH')
    end

    it 'should reset place if already on the tabletop' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      robot.place(position_x: 1, position_y: 1, direction: 'NORTH')
      expect(robot.placed?).to eq true
      expect(robot.position.position_x).to eq 1
      expect(robot.position.position_y).to eq 1
      expect(robot.current_direction).to eq DirectionFinder.get_instance_from_input('NORTH')
      robot.place(position_x: 2, position_y: 1, direction: 'SOUTH')
      expect(robot.placed?).to eq true
      expect(robot.position.position_x).to eq 2
      expect(robot.position.position_y).to eq 1
      expect(robot.current_direction).to eq DirectionFinder.get_instance_from_input('SOUTH')
    end
  end

  describe '#left' do
    it 'should raise error if not placed' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      expect(robot.placed?).to eq false
      expect { robot.left }.to raise_error
    end

    it 'should update direction' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      robot.place(position_x: 1, position_y: 1, direction: 'NORTH')
      expect(robot.current_direction).to eq DirectionFinder.get_instance_from_input('NORTH')
      robot.left
      expect(robot.current_direction).to eq DirectionFinder.get_instance_from_input('WEST')
      robot.left
      expect(robot.current_direction).to eq DirectionFinder.get_instance_from_input('SOUTH')
    end
  end

  describe '#right' do
    it 'should raise error if not placed' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      expect(robot.placed?).to eq false
      expect { robot.right }.to raise_error
    end

    it 'should update direction' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      robot.place(position_x: 1, position_y: 1, direction: 'NORTH')
      expect(robot.current_direction).to eq DirectionFinder.get_instance_from_input('NORTH')
      robot.right
      expect(robot.current_direction).to eq DirectionFinder.get_instance_from_input('EAST')
      robot.right
      expect(robot.current_direction).to eq DirectionFinder.get_instance_from_input('SOUTH')
    end
  end

  describe '#move' do
    it 'should raise error if not placed' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      expect(robot.placed?).to eq false
      expect { robot.move }.to raise_error
    end

    it 'should raise error if cannot move forward' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      robot.place(position_x: 4, position_y: 4, direction: 'NORTH')
      expect { robot.move }.to raise_error(ArgumentError, 'Position is not within the current tabletop')
    end

    it 'should update position' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      robot.place(position_x: 4, position_y: 3, direction: 'NORTH')
      expect(robot.position.position_x).to eq 4
      expect(robot.position.position_y).to eq 3
      robot.move
      expect(robot.current_direction).to eq DirectionFinder.get_instance_from_input('NORTH')
      expect(robot.position.position_x).to eq 4
      expect(robot.position.position_y).to eq 4
    end
  end

  describe '#report' do
    it 'should raise error if not placed' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      expect(robot.placed?).to eq false
      expect { robot.report }.to raise_error
    end

    it 'should print current position and direction' do
      tabletop = Tabletop.new(start_x: 0, start_y: 0, width: 5, height: 5)
      robot = Robot.new(current_tabletop: tabletop)
      robot.place(position_x: 4, position_y: 3, direction: 'NORTH')
      expect do
        robot.report
      end.to output("4,3,NORTH\n").to_stdout
      robot.place(position_x: 0, position_y: 0, direction: 'NORTH')
      expect do
        robot.report
      end.to output("0,0,NORTH\n").to_stdout
    end
  end
end
