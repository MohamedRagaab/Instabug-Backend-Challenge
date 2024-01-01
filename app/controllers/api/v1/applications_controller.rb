module Api
  module V1
    class ApplicationsController < ApplicationController
      before_action :find_application, only: [:show, :update]

      def create
        @application = ChatApplication.new(application_params)

        if @application.save
          render json: { message: 'Application created successfully', application: { name: @application.name, token: @application.token } }, status: :created
        else
          render json: { errors: @application.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: { application: @application.as_json(except: :id) }, status: :ok
      end

      def update
        if @application.update(application_params)
          render json: { message: 'Application updated successfully', application: { name: @application.name, token: @application.token } }, status: :ok
        else
          render json: { errors: @application.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def application_params
        params.require(:application).permit(:name)
      end

      def find_application
        @application = ChatApplication.find_by(token: params[:token])

        render json: { errors: 'Application not found' }, status: :not_found unless @application
      end
    end
  end
end
