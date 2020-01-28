class ApplicationResponder < ActionController::Responder
  private

  def json_resource_errors
    ValidationErrorsSerializer.new(resource).serialize
  end
end
