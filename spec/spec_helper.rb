require "webmock/rspec"
require_relative "../lib/babili"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:example) do
    Babili.configure do |config|
      config.token = "TOKEN"
    end
  end
end
