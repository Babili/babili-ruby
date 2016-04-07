module Babili
  module Platform
    class User < OpenStruct
      @path = "platform/users"

      def self.all
        raw_users = Babili::Client.get(@path)
        raw_users["data"].map do |raw_user|
          user    = self.new(raw_user["attributes"])
          user.id = raw_user["id"]
          user
        end
      end

      def self.create(params = {})
        raw_user = Babili::Client.post(@path, params)["data"]
        user     = self.new(raw_user["attributes"])
        user.id  = raw_user["id"]
        user
      end
    end
  end
end
