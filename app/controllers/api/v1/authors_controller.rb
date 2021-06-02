module Api
    module V1
        class AuthorsController < ApplicationController
            def create
                author = Author.new(author_params)

                if author.save
                    render json: author, status: :created
                else
                    render json: {errors: author.errors}, status: :unprocessable_entity
                end
            end

            private 

            def author_params
                params.require(:author).permit(:first_name, :last_name, :email, :birth_date)
            end
        end
    end
end