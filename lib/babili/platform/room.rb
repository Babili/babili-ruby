module Babili
  module Platform
    class Room < OpenStruct
      def self.path
        "platform/rooms"
      end

      def self.all
        rooms                       = []
        previous_first_seen_room_id = false
        first_seen_room_id          = nil
        while previous_first_seen_room_id != first_seen_room_id
          previous_first_seen_room_id = first_seen_room_id
          if first_seen_room_id
            raw_rooms = Babili::Client.get(path + "?firstSeenRoomId=#{first_seen_room_id}")
          else
            raw_rooms = Babili::Client.get(path)
          end

          return rooms if raw_rooms["data"].empty?
          rooms.concat(raw_rooms["data"].map do |raw_room|
            room    = new(raw_room["attributes"])
            room.id = raw_room["id"]
            room.users = raw_room["relationships"]["users"]["data"].map do |raw_user|
              user = Babili::Platform::User.new({id: raw_user["id"]})
              user
            end
            room
          end)
          first_seen_room_id = raw_rooms["data"].last["id"]
        end
      end

      def self.create(params = {})
        user_ids         = params[:user_ids] || params["user_ids"]
        formatted_params = {
          data: {
            id:         params[:id] || params["id"],
            attributes: {
              name: params[:name] || params["name"]
            },
            relationships: {
              users: {}
            }
          }
        }
        if user_ids
          formatted_params[:data][:relationships][:users][:data] = user_ids.map do |user_id|
            { id: user_id }
          end
        end
        raw_room = Babili::Client.post(path, formatted_params)["data"]
        room     = new(raw_room["attributes"])
        room.id  = raw_room["id"]
        room
      end

      def self.retreive(room_id)
        retreive_path = path + "/#{room_id}"
        raw_room      = Babili::Client.get(retreive_path)["data"]
        room          = new(raw_room["attributes"])
        room.id       = raw_room["id"]
        room
      end

      def messages
        Babili::Platform::Message.all_for_room(self.id)
      end

      def delete
        path     = self.class.path + "/#{id}"
        raw_room = Babili::Client.delete(path)["data"]
        room     = self.class.new(raw_room["attributes"])
        room.id  = raw_room["id"]
        room
      end
    end
  end
end
