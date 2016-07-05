module Babili
  module Platform
    class Message < OpenStruct
      def self.path
        "platform/rooms/:room_id/messages"
      end

      def self.all_for_room(room_id)
        create_path                    = path.gsub(":room_id", room_id)
        messages                       = []
        previous_first_seen_message_id = false
        first_seen_message_id          = nil
        while previous_first_seen_message_id != first_seen_message_id
          previous_first_seen_message_id = first_seen_message_id
          if first_seen_message_id
            raw_messages = Babili::Client.get(create_path + "?firstSeenMessageId=#{first_seen_message_id}")
          else
            raw_messages = Babili::Client.get(create_path)
          end

          return messages if raw_messages["data"].empty?
          messages.concat(raw_messages["data"].map do |raw_message|
            message    = new(raw_message["attributes"])
            message.id = raw_message["id"]
            message
          end)
          first_seen_message_id = raw_messages["data"].first["id"]
        end
      end

      def self.create(params = {})
        room_id          = params.delete(:room_id)
        create_path      = path.gsub(":room_id", room_id)
        sender_id        = params[:sender_id] || params["sender_id"]
        formatted_params = {
          data: {
            type:          "mesage",
            id:            params[:id] || params["id"],
            relationships: {},
            attributes:    {
              content:          params[:content] || params["content"],
              content_type:     params[:content_type] || params["content_type"],
              read_by_user_ids: params[:read_by_user_ids] || params["read_by_user_ids"]
            }
          }
        }
        if sender_id
          formatted_params[:data][:relationships][:user] = {
            data: { id: sender_id }
          }
        end
        raw_message     = Babili::Client.post(create_path, formatted_params)["data"]
        message         = new(raw_message["attributes"])
        message.id      = raw_message["id"]
        message.room_id = room_id
        message
      end

      def delete
        path        = self.class.path.gsub(":room_id", room_id) + "/#{id}"
        raw_message = Babili::Client.delete(path)["data"]
        message     = self.class.new(raw_message["attributes"])
        message.id  = raw_message["id"]
        message
      end
    end
  end
end
