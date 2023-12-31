module Api
  module V1
    class ApplicationsController < ApplicationController
      def create
        @application = ChatApplication.new(application_params)

        if @application.save
          render json: { message: 'Application created successfully', application: {name: @application.name, token: @application.token } }, status: :created
        else
          render json: { errors: @application.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def application_params
        params.require(:application).permit(:name)
      end
    end
  end
end
