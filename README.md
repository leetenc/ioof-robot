# ioof-robot

This is a **IOOF Robot** coding challenge for submisison.

The challenge requirement is as followed:

Create an application that can read in commands of the following form to place a robot in a 5 X 5 grid table top, to move the robot, to turn the robot facing direction, and to report on the position of the robot.  The valid commands and syntax are
```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```
In addtion, each PLACE command instantiate a new robot identified by a sequence number that is subject to the same commands. Only one robot at any one time can be activated to accept commands. A robot becomes active when the `ROBOT id` command is issued, where *id* identifies the robot to be activated. All subsequent commands will be accepted by the active robot until it is deactivated by another ROBOT command.  

By default the first robot placed will become the active robot.

**Note**: If a new robot is initially placed outside the table (negative coordinates are also considered outside the boundary), it is created but will ignore all future commands even when activated (as per coding challenge instruction).

Invalid commands will be ignored (see **User Manual** below)
  
# Installation
Download the GIT repository (leeten/ioof-robot) into a local machine.

The application is written in ruby on linux (MacOS). Hence, an installation of the latest ruby is required to run the application.
RSpec is used to conduct unit testing on the Robot classes
To run test scripts, the following ruby gem has been installed using the following command line:

```
cd <this application folder>
gem install rake bundler rspec
bundle install
```

# User Manual
The application is based on a command line user interface.
Please issue the following command in the console prompt to run the application:

```
cd <application folder> 
ruby lib/run.rb  [width] [height]
```
Parameters **width** & **height** refers to the dimension of the table. They are optional and expected to be integers greater than 0.  If only one parameter is supplied, it is assumed to be both width and height (square table). If no parameter is supplied, the default table dimension is 5 x 5.
  
The application will accept user input until 'quit' or 'exit' is entered. Robot commands issued is *not* case-sensitive.

Although the application accepts user input from the command console, it is recommended to pipe text files containing the robot commands for testing:
```
ruby lib/run.rb 6 4 < test_data/testfile_01
```
The example above is to request the applicaiotn to create a table dimension of **6 X 4** and accept commands stored in the file **./test_data/testfile_01**

#### Test Data Files Supplied for user testing
There are 3 test data files supplied which contain robot commands to be submitted to the application. The test data files are located at `./test_data`
```
./test_data/testfile_01 <-- This file test all possible valid commands
./test_data/testfile_02 <-- This file test the robot that is placed outside the table to ignore all future commands 
./test_data/testfile_03 <-- This file test the rejection of invalid commands
```

**Note**: Robot commands issued will be ignored if
- The command is invalid (must be one of `PLACE x,y,facing`, `ROBOT id`, `MOVE`, `RIGHT`, `LEFT`, `REPORT`)
- ROBOT command is issued with an invalid id
- PLACE command is issued with x or y non-integer values, or the facing direction is not one of *NORTH*, *EAST*, *SOUTH*, or *WEST*.
- The active robot's original placement is outside the table boundary

# Unit Testing using Rspec
Unit Test specification files have been created to test the Robot and RobotManager class objects.  
The test files are located in 
`./spec`

To run the test files in the folder, issue the following command at the application folder:

`bundle exec rspec`

# Application Design
The application consists of 4 main objects:
- **CommandController** : accepts and evaluate the robot commands issued with feed back, delegate valid commands to **RobotManager**
- **Table** : A table object defines the dimension of a table for the robot to move within
- **RobotManager** : An object to instantion and maintain the states of robots
- **Robot** : The robot object to accept valid commands to move around the table and report its position

Each object class is defined within each own ruby class file in the `./lib` folder:
```
./lib/
    command_controller.rb
    table.rb
    robot_manager.rb
    robot.rb
```
`utility.rb` contains helper codes to provide generic global methods (in this case, a method to check if a string is an integer)
  
The run.rb is the starting point for running the application. It instantiates the following objects before user input is accepted:
- **Table** object based on the parameterised width & height
- **RobotManager** with the **Table** object, and
- **CommandController** with the **RobotManager** that the command controller will issue valid commands to.
  
