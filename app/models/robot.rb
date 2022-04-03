# frozen_string_literal: true

class Robot < ModelBase
  attr_reader :position, :current_direction, :current_tabletop

  validates! :current_tabletop, presence: true

  def initialize(**args)
    @position = nil
    @current_direction = nil
    @current_tabletop = args[:current_tabletop] if args[:current_tabletop].is_a? Tabletop
    valid?
  end

  def placed?
    @position.present? && @current_direction.present?
  end

  def place(**args)
    target_position = Position.new(position_x: args[:position_x], position_y: args[:position_y])
    target_direction = DirectionFinder.get_instance_from_input(args[:direction])

    unless @current_tabletop.valid_position?(target_position)
      raise ArgumentError,
            'Position is not within the current tabletop'
    end
    raise ArgumentError, 'Direction is invalid' unless target_direction.present?

    @position = target_position
    @current_direction = target_direction
  end

  def left
    raise StandardError, 'left is not a valid action' unless placed?

    @current_direction = @current_direction.left_direction
  end

  def right
    raise StandardError, 'right is not a valid action' unless placed?

    @current_direction = @current_direction.right_direction
  end

  def move
    raise StandardError, 'move is not a valid action' unless placed?

    next_postion = @current_direction.get_next_position(current_position: @position)
    unless @current_tabletop.valid_position?(next_postion)
      raise ArgumentError,
            'Position is not within the current tabletop'
    end

    @position = next_postion
  end

  def report
    raise StandardError, 'report is not a valid action' unless placed?

    puts "#{@position.position_x},#{@position.position_y},#{@current_direction.to_command}"
  end
end
