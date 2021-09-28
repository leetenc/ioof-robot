# Define the table class
class Table
  def initialize(table_width, table_height)
    @table_width = table_width
    @table_height = table_height
  end

  # is the x,y coordonate within the boundry of the table
  def xy_within_table?(x_pos, y_pos)
    (0...@table_width).include?(x_pos) && (0...@table_height).include?(y_pos)
  end
end
