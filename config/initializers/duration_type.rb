class DurationType < ActiveRecord::Type::String
  def cast(value)
    return value if value.blank? || value.is_a?(ActiveSupport::Duration)
    ActiveSupport::Duration.build(value)
  end

  def serialize(duration)
    duration ? duration.to_i : nil
  end
end

ActiveRecord::Type.register(:duration, DurationType)
