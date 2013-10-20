$:.unshift File.expand_path('../lib', __FILE__)

require "mongoid"
Mongoid.load!("mongoid.yml", ENV["RACK_ENV"].to_sym)

require "server/app"
run Server::App

