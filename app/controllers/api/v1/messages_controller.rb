module Api
  module V1
    class MessagesController < ApplicationController
      before_action :find_chat

      def create
        @message = @chat.messages.new(message_params)

        if @message.save
          render json: { message: 'Message created successfully', message: { number: @message.number } }, status: :created
        else
          render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def search
        query = {
          query: {
            bool: {
              filter: [
                { term: { chat_id: @chat.id } },
                { multi_match: { query: params[:q], fields: ['body'] } }
              ]
            }
          }
        }

        @messages = Message.search(query).records

        render json: @messages, status: :ok
      end

      private

      def find_chat
        @chat = Chat.joins(:chat_application)
                    .find_by(chat_applications: { token: params[:application_token] }, number: params[:chat_number])

        render json: { errors: 'Message not found' }, status: :not_found unless @chat
      end

      def message_params
        params.require(:message).permit(:body)
      end
    end
  end
end
