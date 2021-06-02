class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
    # rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_destroyed(e)
        render json: { errors: e.record.errors }, status: :unprocessable_entity
    end

    # def not_found(e)
    #     render json: {error: "No #{e.model.parameterize} with such id"}, status: 404
    # end
end
