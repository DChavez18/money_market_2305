class ErrorSerializer
  def self.serialize(errors)
    errors = Array(errors)
    formatted_errors = errors.map do |error|
      { detail: error }
    end
    { errors: formatted_errors }
  end
end