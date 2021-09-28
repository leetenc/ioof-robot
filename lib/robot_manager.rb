require_relative 'robot'

# Define the robot manager class
# This class instantiate robots and mantains a list of instatiated robots
# This keeps track of which robot is active
#
# The class is instantiate with a table object
#
# METHODS:
# - add_robot : instantiate a robot with a given position and facing direction on a table
# - activate_robot : active the robot with a given robot ID

class RobotManager
  attr_reader :active_robot

  def initialize(table)
    @table = table
    @robots = {} # start with an empty hash of robots. The structure will be a hash of id:robot object
    @active_robot_id = nil # nil = no active robot
    @robot_sequence = 0  # the sequence# of the last robot created. 0 means none created
  end

  ### Add a new robot to the robots hash
  ### Expect the placement positiion and facing direction to be supplied
  ### Facing direction must be one of 'NORTH', 'EAST', 'SOUTH', 'WEST' - not case sensitive

  def add_robot(x_pos, y_pos, facing)
    @robot_sequence += 1 #add one to the sequence
    @robots[@robot_sequence] = Robot.new(@table, x_pos, y_pos, facing)
    @active_robot_id ||= @robot_sequence # set the id of the active robot
  end

  ### Activate the robot based on a supplied id
  ### Only activate the robot that exists with the id

  def activate_robot(id)
    # need to check if id is a valid identifier of a robot
    @active_robot_id = @robots[id].nil? ? @active_robot_id : id
  end

  def active_robot
    @robots[@active_robot_id]
  end

  ### Report the robot manager stats
  ### if no active robots, no active robots would be reported
  ### otherwise report the count of robots, the active robot name, and the position of the active robot

  def report
    if active_robot.nil?
      "Robot Count: #{@robot_sequence} - no active robot."
    else
      "Robot Count: #{@robot_sequence}, Active: Robot #{@active_robot_id}, Position: #{active_robot.report}"
    end
  end
end
