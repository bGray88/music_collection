class ErrorSerializer
  def self.error(errors)
    {
      "message": error.message,
      "errors":  errors.map { |error| "details": error.details },
      "status":  error.status
    }
  end
end
