class Position < ModelBase  
  attr_accessor :position_x, :position_y

  validates! :position_x, :position_y, numericality: { only_integer: true }, presence: true

  def initialize(**args)
    @position_x = args[:position_x].to_i if args[:position_x].is_a?(Integer) || args[:position_x].is_number?
    @position_y = args[:position_y].to_i if args[:position_y].is_a?(Integer) || args[:position_y].is_number?
  end

end