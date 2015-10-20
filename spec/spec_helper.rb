require 'simplecov'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  # the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  # your HTTP request service.
  c.hook_into :webmock
end
SimpleCov.start
WebMock.disable_net_connect!(allow_localhost: true)
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!

  config.warnings = false

  config.order = :random
end
