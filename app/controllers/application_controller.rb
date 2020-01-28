require "application_responder"

class ApplicationController < ActionController::API
  self.responder = ApplicationResponder
  respond_to :json

  include Knock::Authenticable

  rescue_from ActiveRecord::RecordInvalid,
              with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound,
              with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: {
      message: "Validation Failed",
      errors: ValidationErrorsSerializer.new(exception.record).serialize,
    }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { message: "Not found", code: "not_found" }, status: :not_found
  end
end
