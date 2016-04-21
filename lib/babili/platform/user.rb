module Babili
  module Platform
    class User < OpenStruct
      def self.path
        "platform/users"
      end

      def self.all
        raw_users = Babili::Client.get(path)
        raw_users["data"].map do |raw_user|
          user    = new(raw_user["attributes"])
          user.id = raw_user["id"]
          user
        end
      end

      def self.create(params = {})
        params = {
          data: {
            id:         params["id"] || params [:id],
            attributes: {
              alive_at:                     params["alive_at"]   || params [:alive_at],
              status:                       params["status"]     || params [:status],
              created_at:                   params["created_at"] || params [:created_at],
              updated_at:                   params["updated_at"] || params [:updated_at],
              last_messages_digest_sent_at: params["last_messages_digest_sent_at"] || params [:last_messages_digest_sent_at]
            }
          }
        }

        raw_user = Babili::Client.post(path, params)["data"]
        user     = new(raw_user["attributes"])
        user.id  = raw_user["id"]
        user
      end

      def delete
        path     = self.class.path + "/#{id}"
        raw_user = Babili::Client.delete(path)["data"]
        user     = self.class.new(raw_user["attributes"])
        user.id  = raw_user["id"]
        user
      end
    end
  end
end
