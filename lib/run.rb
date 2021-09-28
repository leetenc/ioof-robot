# The main Robot application component
# Running Instruction:
# ruby run.rb [command files]
#
# Design:
# Class CommandCentre
#   - accept and validate commands
#   - Responsible for creating robots, activate a robot, and report robot status
#   - relegate the movement commands to the activated robots
#
#   Valid Commands:
#   - PLACE X,Y,F
#   - MOVE
#   - LEFT
#   - RIGHT
#   - REPORT
#   If the command is invalid, it will be ignore, and an error code + message is returned

# Define the default dimension of the table
TABLE_WIDTH = 5
TABLE_HEIGHT = 5

# Command line arguments supplied:  optional file name(s)
CMD_ARGUMENTS = ARGV

# Define the table class
class Table
  def intitialize(table_width, table_height)
    @table_width = table_width
    @table_height = table_height
  end

  # is the x,y coordonate within the boundry of the table
  def xy_within_table?(x_pos, y_pos)
    (0...@table_width).include?(x_pos) && (0...@table_height).include?(y_pos)
  end
end


# Define the robot list class
class RobotList
  attr_reader :active_robot

  def intitialize(table)
    @table = table
    @robots = []
    @active_robot = nil
  end

  def add_robot(x_pos, y_pos, facing)
    @robots << Robot.new(x_pos, y_pos, facing)
    active_robot(0) if @active_robot.nil? # activate the first robot if no active robot
  end

  def activate_robot(id)
    status = 0

    # need to check if id an integer
    if (true if Integer(id) rescue false) && id.between?(1, @robots.length)
      @active_robot = @robots[id - 1]
    else
      status = -1
    end

    status
  end
end

# CommandCentre class defintion
class CommandCentre
  def initialize(table, robot_list)
    @table = table
    @robot_list = robot_list
  end

  def accept_command(command_line)
    # status of the command
    # 0 - means it's OK
    # negative numbers means command is invalid
    status = 0

    # grab the commnd and argument in the command line
    command, argument = command_line.upcase.split(' ')

    # intepret the command
    case command
    when 'PLACE' # Place a new robot on the table

      # assign the x,y coordinates, and facing direciton
      x_pos, y_pos, facing = argument.split(',').map(&:strip) #strip blanks spaces

      # check x,y is within the table size
      if @table.xy_within_table?(x_pos, y_pos) && Robot.valid_direction(facing)
        @robot_list.add_robot(x_pos, y_pox, facing)
      else
        status = -1
      end

    when 'ROBOT'
      status = @robot_list.active_robot.activate(argument)

    when 'LEFT'
      @robot_list.active_robot.left

    when 'RIGHT'
      @robot_list.active_robot.right

    when 'MOVE'
      status = @robot_list.active_robot.left

    when 'REPORT'
      puts @robot_list.report
    else
      status = -1
    end

    status
  end
end

# Note:
# As per instruction - PLACE can place robot outside the square, which means it can ignore commands(as per instruction)
# Each robot has an assigned number, if a robot is removed (not impleented), the robot number should be consistent.
