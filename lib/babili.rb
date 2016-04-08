require "ostruct"

require_relative "babili/client"
require_relative "babili/configuration"
require_relative "babili/errors"
require_relative "babili/platform/user"
require_relative "babili/platform/room"
require_relative "babili/platform/message"
require_relative "babili/platform/token"

module Babili
  def self.configure(&block)
    yield @configuration ||= Babili::Configuration.new
  end

  def self.config
    @configuration
  end

  def self.logger
    @logger
  end

  configure do |config|
    config.api_scheme = "https"
    config.api_host   = "babili-api.spin42.me"
    config.api_port   = 443
  end
end

