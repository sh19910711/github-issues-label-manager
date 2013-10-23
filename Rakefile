$:.unshift File.expand_path('../lib', __FILE__)

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new :spec

require "rake/clean"
CLEAN << ".yardoc"

require "rake/yard/routes"
require "rake/requirejs/paths"

