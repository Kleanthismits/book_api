# Rescue StandardError acts as a Fallback mechanism to handle any exception
module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from StandardError do |e|
          render json: { errors: { message: e.message } }, status: :internal_server_error
        end
      end
    end
  end
end
