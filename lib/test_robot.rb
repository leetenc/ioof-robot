require_relative 'robot'
require_relative 'table'
require_relative 'robot_manager'

table = Table.new(5, 5)
robot = Robot.new(table, 1, 2, 'NORTH')

puts robot.current_position

robot.move
puts robot.current_position

robot.turn('LEFT')
robot.move

puts robot.current_position

# test robot manager

robot_manager = RobotManager.new(table)

puts robot_manager.report

robot_manager.add_robot(2, 3, 'NORTH')

puts robot_manager.report

robot_manager.activate_robot(2)

puts robot_manager.report

robot_manager.add_robot(1, 0, 'EAST')
robot_manager.activate_robot(2)
puts robot_manager.report

robot_manager.add_robot(0, 10, 'EAST')
robot_manager.activate_robot(3)
puts robot_manager.report

robot_manager.activate_robot(2)
robot_manager.active_robot.turn('RIGHT')
robot_manager.active_robot.move
robot_manager.active_robot.move
puts robot_manager.report
robot_manager.active_robot.turn('RIGHT')
robot_manager.active_robot.move
puts robot_manager.report
