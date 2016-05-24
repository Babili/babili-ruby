module Babili
  module Platform
    class MessagesDigest < OpenStruct
      @path = "platform/messages-digests"

      def self.create
        raw_digest = Babili::Client.post(@path, {})
        digest     = new(raw_digest["meta"])
        digest
      end
    end
  end
end
