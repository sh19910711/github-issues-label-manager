require "simplecov"
require "simplecov-rcov"
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

require "rack/test"
require "spork"

GITHUB_ACCESS_TOKEN = ENV["GITHUB_ACCESS_TOKEN"]
TEST_EYE_GREP_MODE = ENV["TEST_EYE_GREP_MODE"] === "TRUE"

require "webmock/rspec"
WebMock.allow_net_connect! if TEST_EYE_GREP_MODE

Spork.prefork do
  RSpec.configure do |config|
    config.include Rack::Test::Methods
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.filter_run :focus
    config.order = 'random'
  end

  RSpec.configure do |config|
    config.before do
      body = readmock "api.github.com/user/octocat.json"
      stub_request(
        :get,
        "https://api.github.com/user",
      ).to_return(
        {
          :status   => 200,
          :headers  => {
            "Content-Length" => body.length,
            "Content-Type"   => "application/json"
          },
          :body     => body,
        },
        )
    end
    config.before { @github = Server::Common::GitHub.new("test-access-token") }
  end

  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
end

Spork.prefork do
  unless ENV['DRB']
    require 'simplecov'
  end
end

Spork.each_run do
  if ENV['DRB']
    require 'simplecov'
  end
end

require "server/app"

def source_env path
  File.readlines(path).each do |line|
    values = line.split "="
    ENV[values[0].strip] = values[1].strip
  end
end

def mockpath path
  File.join File.dirname(__FILE__), "/mock/#{path}"
end

def readmock path
  File.read mockpath path
end

