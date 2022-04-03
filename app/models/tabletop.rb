# frozen_string_literal: true

class Tabletop < ModelBase
  attr_reader :start_x, :start_y, :end_x, :end_y

  validates! :start_x, :start_y, numericality: { only_integer: true }, presence: true
  validates! :end_x, numericality: { greater_than_or_equal_to: :start_x, only_integer: true }, presence: true
  validates! :end_y, numericality: { greater_than_or_equal_to: :start_y, only_integer: true }, presence: true

  def initialize(**args)
    @start_x = args[:start_x].to_i if args[:start_x].to_s.is_number?
    @start_y = args[:start_y].to_i if args[:start_y].to_s.is_number?
    @end_x = @start_x + args[:width].to_i - 1 if @start_x.present? && args[:width].to_s.is_number?
    @end_y = @start_y + args[:height].to_i - 1 if @start_y.present? && args[:height].to_s.is_number?
    valid?
  end

  def valid_position?(position)
    return false unless position.is_a? Position

    (position.position_x >= @start_x && position.position_x <= @end_x) && (position.position_y >= @start_y && position.position_y <= @end_y)
  end
end
