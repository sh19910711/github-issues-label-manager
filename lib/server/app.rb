require "sinatra/base"
require "sinatra/ext/session"

SESSION_KEY    = ENV['GILM_SESSION_KEY']    || 'GILM_SESSION'
SESSION_SECRET = ENV['GILM_SESSION_SECRET'] || ''

module Server
  class App < Sinatra::Base
    set :session_settings, {
      :key      => SESSION_KEY,
      :secret   => SESSION_SECRET,
    }

    register Sinatra::Extension::Session 
  end
end

