require 'robot'
require 'table'
require 'robot_manager'

describe RobotManager do
  describe 'Robot manager with a table 5x5' do
    let(:table)       { Table.new(5, 5) }
    let(:robot_man1)  { RobotManager.new(table) }

    context 'Instantate empty RobotManager' do
      it '- report should return no robots message' do
        report = robot_man1.report
        expect(report).to eq('Robot Count: 0 - no active robot.')
      end
    end

    let(:robot_manager) { RobotManager.new(table) }

    context 'Add robots to RobotManager' do
      it '- report should return correct messages for adding first robots' do
        robot_manager.add_robot(2, 3, 'NORTH')
        expect(robot_manager.report).to eq('Robot Count: 1, Active: Robot 1, Position: 2,3,NORTH')

        robot_manager.add_robot(1, 0, 'EAST')
        robot_manager.activate_robot(2)
        expect(robot_manager.report).to eq('Robot Count: 2, Active: Robot 2, Position: 1,0,EAST')

        robot_manager.add_robot(0, 10, 'EAST')
        robot_manager.activate_robot(3)
        expect(robot_manager.report).to eq('Robot Count: 3, Active: Robot 3, Position: 0,10,EAST - Invalid original placement.')
      end
    end
  end
end
