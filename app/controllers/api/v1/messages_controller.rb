module Api
  module V1
    class MessagesController < ApplicationController
      before_action :find_chat, except: :search

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
          bool: {
            must: [
              { multi_match: { query: params[:q], fields: ['body'] } },
              { term: { chat_id: @chat.id } }
            ]
          }
        }

        @messages = Message.search(query)

        render json: @messages, status: :ok
      end

      private

      def find_chat
        @chat = Chat.joins(:chat_application)
                    .find_by(chat_applications: { token: params[:application_token] }, number: params[:chat_number])

        render json: { errors: 'Chat not found' }, status: :not_found unless @chat
      end

      def message_params
        params.require(:message).permit(:body)
      end
    end
  end
end
