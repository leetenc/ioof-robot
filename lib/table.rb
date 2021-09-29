# Define the table class
# A class to simple hold teh table dimension and
# provide a methd to detact if a coordinate is within the table boundary

class Table
  def initialize(table_width, table_height)
    @table_width = table_width
    @table_height = table_height
  end

  # Check if the (x_pos,y_pos) coordinate is within the boundry of the table
  def xy_within_table?(x_pos, y_pos)
    (0...@table_width).include?(x_pos) && (0...@table_height).include?(y_pos)
  end
end
