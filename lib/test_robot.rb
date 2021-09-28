require_relative 'robot'
require_relative 'table'

table = Table.new(5, 5)
robot = Robot.new(table, 1, 2, 'NORTH')

puts robot.current_position

robot.move
puts robot.current_position

robot.turn('LEFT')
robot.move

puts robot.current_position
