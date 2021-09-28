# ioof-robot
IOOF Robot coding challenge

This is a IOOF Robot coding challenge for submisison.

The challenge requirement is a as followed:

Create an application that can read in commands of the following form to place a robot in a 5 X 5 grid table top, to move the robot, to turn the robot facing direction, and to report on the position of the robot

PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT

In addtion, each PLACE command instantiate a new robot identified by a sequence number that is subject to the same commands. Only one robot at any one time can be activated to accept commands. A robot becomes active when the ROBOT <id> commnd is issued, where <id> identified the robot to be avtivated. All susequent commend will be accepted by the active until it is deactivated by another ROBOT command.  

By default the first robot placed will become the active robot.


# Installation
The applicaiton is written in ruby on linux (MacOS). Hence, an installation of the latest ruby is required to run the application.
To run test scripts, the following ruby gem has been install using the following command line:

gem install rake bundler rspec

# User Manual
The application is based on a command line user interface.
Please issue the following command line to run the application:

cd <application folder> 

ruby run.rb  [command files...]

Comman files are the files containing the robot commands to be fed through the application.

Omitting the command files would allow interative user entry of the same commands at prompt. 

# Testing using Rspec
Test specification files has been created to test individua objects.  The test files are located in spec/
To run the test files in the folder, issue the following command in console:

bundle exec rspec 

