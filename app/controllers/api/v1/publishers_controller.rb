module Api
  module V1
    class PublishersController < ApplicationController
      def create
        publisher = Publisher.new(publisher_params)

        if publisher.save
          render json: publisher, status: :created
        else
          render json: { errors: publisher.errors }, status: :unprocessable_entity
        end
      end

      private

      def publisher_params
        params.require(:publisher).permit(:name, :telephone, :address)
      end
    end
  end
end
