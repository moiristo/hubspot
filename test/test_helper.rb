# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'vcr'

Rails.backtrace_cleaner.remove_silencers!

# Turn on debugging output
Hubspot.config.debug_http_output = STDOUT

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path("../fixtures/vcr_cassettes", __FILE__)
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock
end