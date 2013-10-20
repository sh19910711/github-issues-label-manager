$:.unshift File.expand_path('../lib', __FILE__)

require "mongoid"
Mongoid.load! "mongoid.yml", :development

require "server/models"
require "server/common"

