require_relative 'utility'
require_relative 'robot'
require_relative 'table'
require_relative 'robot_manager'
require_relative 'command_controller'


table = Table.new(5, 5)
robot = Robot.new(table, 1, 2, 'NORTH')

puts 'Testing Robot class\n----------'
puts robot.current_position

robot.move
puts robot.current_position

robot.turn('LEFT')
robot.move

puts robot.current_position

# test robot manager
puts 'Testing Robot Manager\n----------'
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

# test CommandController
puts 'Testing Command Controller\n----------'
robot_manager2 = RobotManager.new(table)
controller = CommandController.new(robot_manager2)
controller.accept_command('PLACE 0,0,NORTH')
controller.accept_command('REPORT')
controller.accept_command('PLACE 2,3,EAT')
controller.accept_command('ROBOT 2')
controller.accept_command('REPORT')
controller.accept_command('PLACE 2,0,EAST')
controller.accept_command('ROBOT 2')
controller.accept_command('RIGHT')
controller.accept_command('MOVE')
controller.accept_command('REPORT')
controller.accept_command('PLACE -2,a,EAST')
controller.accept_command('REPORT')

controller.accept_command('BAD Command')
