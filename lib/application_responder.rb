class ApplicationResponder < ActionController::Responder
  private

  def json_resource_errors
    {
      message: "Validation Failed",
      errors: ValidationErrorsSerializer.new(resource).serialize,
    }
  end
end
