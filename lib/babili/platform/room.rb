module Babili
  module Platform
    class Room < OpenStruct
      def self.path
        "platform/rooms"
      end

      def self.all
        raw_rooms = Babili::Client.get(path)
        raw_rooms["data"].map do |raw_room|
          room    = new(raw_room["attributes"])
          room.id = raw_room["id"]
          room
        end
      end

      def self.create(params = {})
        formatted_params = {
          data: {
            id:         params[:id] || params["id"],
            attributes: {
              name: params[:name] || params[:name]
            },
            relationships: {}
          }
        }
        if params["user_ids"] || params[:user_ids]
          formatted_params[:relationships][:users] = params[:user_ids].map do |user_id|
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

      def delete
        path     = self.class.path + "/#{id}"
        raw_room = Babili::Client.delete(path)["data"]
        room     = self.class.new(raw_room["attributes"])
        room.id  = raw_room["id"]
        room
      end

      def users
        path      = self.class.path + "/#{id}/users"
        raw_users = Babili::Client.get(path)
        raw_users["data"].map do |raw_user|
          user    = Babili::Platform::User.new(raw_user["attributes"])
          user.id = raw_user["id"]
          user
        end
      end
    end
  end
end
