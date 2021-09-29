require_relative 'utility'

# CommandController Class
#
# Design:
# Class CommandController
#   - Responsible for accepting, validate, and delgate commands
#      - creating robot manger and a table
#      - issue commands to robot manager :
#         create robot, activate robot, move active robot, turn active robots report status)
#
#
#   Valid Commands:
#   - PLACE x,y,facing   where X, Y are positive integers (>=0), facing is one of 'NORTH', 'EAST', 'SOUTH', 'WEST'
#   - MOVE
#   - LEFT
#   - RIGHT
#   - REPORT
#   - ROBOT n   where n is the id of the robot starting from 1, sequentially increasing as robot are being added
#   If the command is invalid, it will be ignore.
#
# Note:
# As per instruction - PLACE can place robot outside the square, which means it can ignore commands(as per instruction)

class CommandController
  def initialize(robot_manager)
    @robot_manager = robot_manager
  end

  def accept_command(command_line)
    # status of the command
    # 0 - means it's OK
    # negative numbers means command is not accepted or ignored
    status = 0

    puts command_line # print out the command issued to Command Controller

    # grab the commnd and argument in the command line
    command, argument = command_line.upcase.split(' ')

    # intepret the command
    case command

    ### Place a new robot on the table
    when 'PLACE'

      # assign the x,y coordinates, and facing direciton
      x_pos, y_pos, facing = (argument.nil? ? '' : argument).split(',').map(&:strip) # strip blanks spaces

      # check if x_pos and y_pos are both integers (in string)
      if integer?(x_pos) && integer?(y_pos) && Robot.valid_direction?(facing)
        @robot_manager.add_robot(x_pos.to_i, y_pos.to_i, facing)
      else
        status = -1
      end

    ### Activate a robot based on ID

    when 'ROBOT'
      status = @robot_manager.activate_robot(argument)

    ### Turn active robot left or right

    when 'LEFT', 'RIGHT'
      status = @robot_manager.turn(command)

    ### Move active robot forward

    when 'MOVE'
      status = @robot_manager.move

    ### report on the robot manager and active robot status

    when 'REPORT'
      puts "Output: #{@robot_manager.report}\n\n"

    else
      status = -1 # this indicates invalid command
    end

    ### print the reject/ignored massage if the status is not 0
    puts "  -** Command rejected/ignored **-\n\n" unless status.nil? || status.zero?
  end
end
