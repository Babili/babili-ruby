module Babili
  module Platform
    class Room < OpenStruct
      @@path = "platform/rooms"

      def self.all
        raw_rooms = Babili::Client.get(path)
        raw_rooms["data"].map do |raw_room|
          room    = self.new(raw_room["attributes"])
          room.id = raw_room["id"]
          room
        end
      end

      def self.create(params = {})
        raw_room = Babili::Client.post(path, params)["data"]
        room     = self.new(raw_room["attributes"])
        room.id  = raw_room["id"]
        room
      end

      def self.retreive(room_id)
        retreive_path = path + "/#{room_id}"
        raw_room      = Babili::Client.get(retreive_path)["data"]
        room          = self.new(raw_room["attributes"])
        room.id       = raw_room["id"]
        room
      end

      def delete
        path     = self.class.path + "/#{id}"
        raw_room = Babili::Client.delete(path)["data"]
        room     = self.class.new(raw_room["attributes"])
        room.id  = raw_room["id"]
        room
      end

      private

      def self.path
        @@path
      end

    end
  end
end
