require_relative 'table'

### Define the Robot class to instantiate teh robot, and accept commands.
### Commands are ignored, if one of the following is true
### - robot is at a position place outside the table bounds
###    NOTE: as per instruction, if the PLACE command place the robot outside the table, it will place the robot outside the table
### - if the initial facing direction provided is invalid
### Robot Class methods:
### - initialize method requires table object, the starting x,y position, and facing dircection (string 'NORTH', 'EAST', 'SOUTH', 'WEST')
### - turn method requires a turning direction. Valid values are 'LEFT' or 'RIGHT'
### - move method move teh robot position in the direction it is facing
class Robot
  # define a constant to hold the movement along x and y coordinate based on facing direction
  MOVEMENT = {
    NORTH: { dx:  0, dy:  1 },
     EAST: { dx:  1, dy:  0 },
    SOUTH: { dx:  0, dy: -1 },
     WEST: { dx: -1, dy:  0 }
  }.freeze

  DIRECTIONS = MOVEMENT.keys.freeze # Get the directions from the movement [:NORTH, :EAST,...]
  TURN = { LEFT: -1, RIGHT: 1 }.freeze # Turning direction -1 for anticlockwise, 1 for clockwise turn

  def initialize(table, x_pos, y_pos, facing)
    @table = table
    @x_pos = x_pos
    @y_pos = y_pos
    @facing = facing.upcase.to_sym
    @movement = MOVEMENT[@facing] # assign the directional movement
    @valid_placement = valid_direction? && @table.xy_within_table?(x_pos, y_pos)
  end

  ### check if the facing direction provided is a valid direction

  def valid_direction?
    !DIRECTIONS.index(@facing).nil?
  end

  ### Turn the face : direction (string) =  'LEFT' (turn anti-clockwise), 'RIGHT' (turn clockwise)
  ### This is ignored if the robot original placement is invalid, or the direction given is invalid
  ### status returned is 0 if command executed sucessfully,-1 otherwise

  def turn(direction)
    status = 0
    if @valid_placement
      turn_direction = TURN[direction.upcase.to_sym]
      if !turn_direction.nil?
        @facing = DIRECTIONS[(DIRECTIONS.index(@facing) + turn_direction) % DIRECTIONS.length]
        @movement = MOVEMENT[@facing]
      else
        status = -1
      end
    end
    status
  end

  ### Move the robot position based on facing direction
  ### provided it is within the table bounds
  ### return status = 0 if command is executed sucessfully, otherwise -1
  ### command is ignored if original placement is invalid.

  def move
    status = 0
    if @valid_placement
      new_x_pos = @x_pos + @movement[:dx]
      new_y_pos = @y_pos + @movement[:dy]

      if @table.xy_within_table?(new_x_pos, new_y_pos)
        @x_pos = new_x_pos
        @y_pos = new_y_pos
      else
        status = -1
      end
    else
      status = -1
    end
    status
  end

  ### Return the current position and the facing direction as a hash object

  def current_position
    { x_pos: @x_pos, y_pos: @y_pos, facing: @facing, valid_placement: @valid_placement}
  end
end

