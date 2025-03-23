# frozen_string_literal: true

class GraphqlController < ApiBaseController
  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user,
      current_device_uid: current_device_uid,
      current_client_device: current_client_device,
      current_country: current_country,
      current_ip: current_ip,
      headers: request.headers
      # current_locale: current_locale,
      # current_locale_country: current_locale_country,
      # current_locale_lang: current_locale_lang
    }
    result =
      GpApiSchema.execute(
        query,
        variables: variables,
        context: context,
        operation_name: operation_name
      )
    # ap result.to_h if Rails.env.development?

    render json: result, status: status(result)
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      variables_param.present? ? JSON.parse(variables_param) || {} : {}
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: {
             errors: [{ message: e.message, backtrace: e.backtrace }],
             data: {
             }
           },
           status: 500
  end

  def status(result)
    errors_array = result.to_h["errors"]

    if errors_array.present? && errors_array[0]["message"] == "Unauthorized"
      401
    else
      200
    end
  end
end
