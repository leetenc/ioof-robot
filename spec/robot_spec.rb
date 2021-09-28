require 'robot'
require 'table'

describe Robot do
  describe 'new robot in table 5x5' do
    let(:table)       { Table.new(5, 5) }
    let(:robot)       { Robot.new(table, 1, 2, 'NORTH') }
    context 'Placement position 1, 2, NORTH' do
      it 'should return the robot poisiton x_pos:1, y_pos:2, facing:NORTH, valid_placement=true' do
        pos = robot.current_position
        expect(pos[:x_pos]).to eq(1)
        expect(pos[:y_pos]).to eq(2)
        expect(pos[:facing]).to eq(:NORTH)
        expect(pos[:valid_placement]).to eq(true)
      end
    end

    context 'Move to position 1, 3, NORTH' do
      it 'should return the robot poisiton x_pos:1, y_pos:3, facing:NORTH, valid_placement=true' do
        robot.move
        pos = robot.current_position
        expect(pos[:x_pos]).to eq(1)
        expect(pos[:y_pos]).to eq(3)
        expect(pos[:facing]).to eq(:NORTH)
        expect(pos[:valid_placement]).to eq(true)
      end
    end

    let(:robot1)       { Robot.new(table, 1, 2, 'XXX') }
    context 'Invalid Placement incorrect facing' do
      it 'should return the robot poisiton x_pos:1, y_pos:2, facing: XXX, valid_placement=false' do
        pos = robot1.current_position
        expect(pos[:facing]).to eq(:XXX)
        expect(pos[:valid_placement]).to eq(false)
      end
    end

    let(:robot2)       { Robot.new(table, 6, 2, 'NORTH') }
    context 'Invalid Placement position outside table' do
      it 'should return the robot poisiton x_pos:6, y_pos:2, facing: NORTH, valid_placement=false' do
        pos = robot2.current_position
        expect(pos[:x_pos]).to eq(6)
        expect(pos[:y_pos]).to eq(2)
        expect(pos[:valid_placement]).to eq(false)
      end
    end

    let(:robot3)       { Robot.new(table, 1, -2, 'WEST') }
    context 'Invalid Placement position outside table' do
      it 'should return the robot poisiton x_pos:1, y_pos:-2, facing: NORTH, valid_placement=false' do
        pos = robot3.current_position
        expect(pos[:x_pos]).to eq(1)
        expect(pos[:y_pos]).to eq(-2)
        expect(pos[:valid_placement]).to eq(false)
      end
    end

    context 'Turn Left and move to position 0, 3, WEST' do
      let(:robot4)       { Robot.new(table, 1, 3, 'NORTH') }
      it 'should return the robot poisiton x_pos:0, y_pos:3, facing:WEST, valid_placement=true' do
        robot4.turn('LEFT')
        robot4.move
        pos = robot4.current_position
        expect(pos[:x_pos]).to eq(0)
        expect(pos[:y_pos]).to eq(3)
        expect(pos[:facing]).to eq(:WEST)
        expect(pos[:valid_placement]).to eq(true)
      end
    end

    context 'Turn right and move to position 2, 3, EAST' do
      let(:robot5)       { Robot.new(table, 1, 3, 'NORTH') }
      it 'should return the robot poisiton x_pos:2, y_pos:3, facing:EAST, valid_placement=true' do
        robot5.turn('RIGHT')
        robot5.move
        pos = robot5.current_position
        expect(pos[:x_pos]).to eq(2)
        expect(pos[:y_pos]).to eq(3)
        expect(pos[:facing]).to eq(:EAST)
        expect(pos[:valid_placement]).to eq(true)
      end
    end

    context 'Turn ignore a move off the table - remain still' do
      let(:robot6)       { Robot.new(table, 0, 0, 'SOUTH') }
      it 'should return the robot poisiton x_pos:0, y_pos:0, facing:SOUTH, valid_placement=true, status = -1' do
        status = robot6.move
        pos = robot6.current_position
        expect(pos[:x_pos]).to eq(0)
        expect(pos[:y_pos]).to eq(0)
        expect(pos[:facing]).to eq(:SOUTH)
        expect(pos[:valid_placement]).to eq(true)
        expect(status).to eq(-1)
      end
    end
  end
end
