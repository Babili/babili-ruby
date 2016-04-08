module Babili
  module Platform
    class Membership < OpenStruct
      attr_accessor :room_id
      attr_accessor :user_id

      @@path = "platform/rooms/:room_id/users/:user_id/membership"

      def delete
        delete_path        = self.class.path.gsub(":room_id", @room_id).gsub(":user_id", @user_id)
        raw_membership     = Babili::Client.delete(delete_path, params)["data"]
        membership         = self.class.new(raw_membership["attributes"])
        membership.room_id = raw_membership["relationships"]["room"]["data"]["id"]
        membership.user_id = raw_membership["relationships"]["user"]["data"]["id"]
        membership
      end

      def self.create(params = {})
        room_id            = params.delete(:room_id)
        user_id            = params.delete(:user_id)
        create_path        = path.gsub(":room_id", room_id).gsub(":user_id", user_id)
        raw_membership     = Babili::Client.post(create_path, {})["data"]
        membership         = new(raw_membership["attributes"])
        membership.room_id = raw_membership["relationships"]["room"]["data"]["id"]
        membership.user_id = raw_membership["relationships"]["user"]["data"]["id"]
        membership
      end

      private

      def self.path
        @@path
      end
    end
  end
end
