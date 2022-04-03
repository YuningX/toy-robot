class Robot < ModelBase
  attr_reader :position, :current_direction, :current_tabletop

  validates! :current_tabletop, presence: true
  validates! :current_direction, presence: true, if: -> { placed? }

  def initialize(**args)
    @position = nil
    @current_direction = nil
    @current_tabletop = args[:current_tabletop] if args[:current_tabletop].is_a? Tabletop
  end

  def placed?
    @position.present?
  end

  def place(**args)
    target_position = Position.new(position_x: args[:position_x], position_y: args[:position_y])
    target_direction = Directions::Base.get_instance_from_input(args[:direction])

    raise ArgumentError, 'Position is not within the current tabletop' unless @current_tabletop.valid_position?(target_position)

    @position = target_position
    @current_direction = target_direction
  end
  
  def left
    raise StandardError, "left is not a valid action" unless placed?
    left_direction = @current_direction.left_direction
    raise ArgumentError, 'Direction is invalid' unless left_direction.is_a? Directions::Base
    @current_direction = left_direction
  end

  def right
    raise StandardError, "right is not a valid action" unless placed?
    right_direction = @current_direction.right_direction
    raise ArgumentError, 'Direction is invalid' unless right_direction.is_a? Directions::Base
    @current_direction = right_direction
  end

  def move
    raise StandardError, "move is not a valid action" unless placed?
    next_postion = @current_direction.get_next_position(current_position: @position)
    raise ArgumentError, 'Position is not within the current tabletop' unless @current_tabletop.valid_position?(next_postion)
    @position = next_postion
  end

  def report
    raise StandardError, "report is not a valid action" unless placed?
    puts "#{@position.position_x}, #{@position.position_y}, #{@current_direction.command_text}"
  end
  
end