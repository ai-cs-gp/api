class BaseMutation < Mutations::Command
  def handle_model(model, args = {})
    args[:inputs] = inputs if args[:inputs].nil?
    unless model.valid?
      add_error(
        model.class.name.downcase.to_sym,
        :error,
        model.errors.full_messages.join(", ")
      )
      model
        .errors
        .messages
        .select { |k| args[:inputs].keys.include? k.to_s }
        .each do |k, v|
          msg = "#{k} #{v.join(", ")}"
          add_error(k.to_s.camelize(:lower), :error, msg)
        end
      return
    end
    model
  end
end
