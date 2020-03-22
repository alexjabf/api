# frozen_string_literal: true

# Response Concern
module Response
  def json_response(message, success, data, status)
    render json: {
      message: message,
      success?: success,
      data: data,
      status: status
    }, status: status
  end
end
