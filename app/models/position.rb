# frozen_string_literal: true

class Position < ModelBase
  attr_reader :position_x, :position_y

  validates! :position_x, :position_y, numericality: { only_integer: true }, presence: true

  def initialize(**args)
    @position_x = args[:position_x].to_i if args[:position_x].to_s.is_number?
    @position_y = args[:position_y].to_i if args[:position_y].to_s.is_number?
    valid?
  end
end
