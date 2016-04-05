require "uri"
require "rest_client"

module Babili
  class Client
    def self.get(resource, data = {})
      headers  = { params: data }.merge(headers)
      response = RestClient.get(uri(resource), headers)
      JSON.parse(response)
    end

    def self.post(resource, data)
      data = data ? data.to_json : nil
      response = RestClient.post(uri(resource), data, headers)
      JSON.parse(response)
    end

    def self.put(resource, data)
      data = data ? data.to_json : nil
      response = RestClient.put(uri(resource), data, headers)
      JSON.parse(response)
    end

    def self.delete(resource, data = {})
      headers  = { params: data }.merge(headers)
      response = RestClient.delete(uri(resource), headers)
      JSON.parse(response)
    end

    private

    def self.uri(resource)
      base_url = "#{Babili.config.api_scheme}://#{Babili.config.api_host}:#{Babili.config.api_port}"
      URI.join(base_url, resource).to_s
    end

    def self.headers
      {
        content_type: :json,
        accept:       :json,
        api_key:      Babili.config.api_key,
        api_secret:   Babili.config.api_secret
      }
    end
  end
end
