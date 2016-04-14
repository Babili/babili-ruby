require "uri"
require "rest_client"

module Babili
  class Client
    def self.get(path, query_params = {})
      execute(:get, uri(path), headers, query_params)
    end

    def self.post(path, payload, query_params = {})
      execute(:post, uri(path), headers, nil, payload)
    end

    def self.put(path, payload, query_params = {})
      execute(:put, uri(path), headers, nil, payload)
    end

    def self.delete(path, query_params = {})
      execute(:delete, uri(path), headers, query_params)
    end

    private

    def self.execute(method, url, headers, query_params = {}, payload = nil)
      query = {
        method:  method,
        url:     url,
        headers: { params: query_params }.merge(headers),
        payload: payload
      }

      raw_response = RestClient::Request.execute(query)
      JSON.parse(raw_response)
    end

    def self.uri(path)
      base_url = "#{Babili.config.api_scheme}://#{Babili.config.api_host}:#{Babili.config.api_port}"
      URI.join(base_url, path).to_s
    end

    def self.headers
      if !Babili.config.platform_token
        raise TokenMissingError.new("You must define an platform token before calling the API.")
      end
      {
        authorization: "Bearer #{Babili.config.platform_token}"
      }
    end
  end
end
