$:.unshift File.expand_path('../lib', __FILE__)

require "server/app"
run Server::App

