module Babili
  module Platform
    class Token < OpenStruct
      @path = "platform/users/:user_id/tokens"

      def self.for_user_id(user_id)
        path = @path.gsub(":user_id", user_id)
        raw_token = Babili::Client.post(path, {})
        raw_token["data"]["attributes"]["token"]
      end
    end
  end
end
