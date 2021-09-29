require_relative 'utility'
require_relative 'table'
require_relative 'robot_manager'
require_relative 'command_controller'

# The main Robot application component
# Running Instruction:
# At the root of the applicaiton folder:
# ruby lib/run.rb [table width] [table height]
#   - where [table width] & [table height] are optional positive integer arguments,
#     setting the width and height of the table
#   - if no argument is supplied, the default 5 x 5 table is assumed
#   - if only one argument is supplied, the value sets both width and height of the table
# e.g. ruby lib/run.rb 6 7
#      This set the table to 6 units wide , 7 units in height
#
# To use a test file containing teh robot commands try issuing this in teh console:
# ruby lib/run.rb < test_data/testfile_01

# Define the default dimension of the table, can be overriden with supplied command line arguments
DEFAULT_WIDTH = 5
DEFAULT_HEIGHT = 5

# Command line arguments supplied in ARGV: expect 1, 2 or no arguments
# expect [widt] [height]
HELP_TEXT = "Command Help:\n\truby lib/run.rb [width] [height]".freeze

# check the ARGV
case ARGV.length

when 1 # 1 argument supplied, assumes it is a sqaure table.
  # check it is an integer
  raise Exception.new "Invalid command line argument. Expecting integer.\n\n#{HELP_TEXT}" unless integer?(ARGV[0])
  width = ARGV[0].to_i
  height = width

when 2 # 2 arguments - expect width & heihgt supplied are integers
  raise Exception.new "Invalid command line arguments. Expecting integers.\n\n#{HELP_TEXT}" unless integer?(ARGV[0]) && integer?(ARGV[1])
  width = ARGV[0].to_i
  height = ARGV[1].to_i
else
  width = DEFAULT_WIDTH
  height = DEFAULT_HEIGHT
end

# check that the width and height are both > 0
raise Exception.new 'Invalid width or height supplied. They need to be greater than 0.' unless width > 0 && height > 0

puts "Table dimentsion is set to Width: #{width} X Height: #{height}"

#
### let's create the table, robot manager, and command controller objects
#

table = Table.new(width, height)
robot_manager = RobotManager.new(table)
command_controller = CommandController.new(robot_manager)

# now accept user commands
puts 'Enter valid robot commands until you enter "quit" or "exit" '
loop do
  # get the user input from standard input
  command = STDIN.gets

  # exitloop if user quit/exit or end of standard input reached
  break if command.nil? || ['quit', 'exit'].include?(command.strip.downcase.chomp)

  # issue the command to the command controller
  command = command.strip.chomp
  command_controller.accept_command(command) unless command == ''
end
