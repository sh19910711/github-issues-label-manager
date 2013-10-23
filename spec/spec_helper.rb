require "simplecov"
require "simplecov-rcov"
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

require "rack/test"
require "spork"

GITHUB_ACCESS_TOKEN = ENV["GITHUB_ACCESS_TOKEN"]
TEST_EYE_GREP_MODE = ENV["TEST_EYE_GREP_MODE"] === "TRUE"

Spork.prefork do
  RSpec.configure do |config|
    config.include Rack::Test::Methods
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.filter_run :focus
    config.order = 'random'
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

def source_env path
  File.readlines(path).each do |line|
    values = line.split "="
    ENV[values[0].strip] = values[1].strip
  end
end

