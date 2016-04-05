module Babili
  class Configuration
    include ActiveSupport::Configurable
    config_accessor :api_scheme
    config_accessor :api_host
    config_accessor :api_port
    config_accessor :api_key
    config_accessor :api_secret
  end
end
