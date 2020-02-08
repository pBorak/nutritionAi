module ValidationErrorsHelper
  def build_validation_errors(resource, field, code)
    {
      "resource": resource,
      "field": field,
      "code": code,
    }.to_json
  end
end
