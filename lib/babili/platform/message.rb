module Babili
  module Platform
    class Message < OpenStruct
      attr_accessor :room_id

      @@path = "platform/rooms/:room_id/messages"

      def self.create(params = {})
        room_id         = params.delete(:room_id)
        create_path     = path.gsub(":room_id", room_id)
        raw_message     = Babili::Client.post(create_path, params)["data"]
        message         = new(raw_message["attributes"])
        message.id      = raw_message["id"]
        message.room_id = room_id
        message
      end

      def delete
        path            = self.class.path.gsub(":room_id", @room_id) + "/#{id}"
        raw_message     = Babili::Client.delete(path)["data"]
        message         = self.class.new(raw_message["attributes"])
        message.id      = raw_message["id"]
        message.room_id = raw_message["attributes"]["roomId"]
        message
      end

      private

      def self.path
        @@path
      end
    end
  end
end
