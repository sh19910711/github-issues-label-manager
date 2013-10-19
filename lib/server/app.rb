require "server/config"
require "sinatra/base"
require "sinatra/ext/session"
require "sinatra/ext/github"

module Server
  class App < Sinatra::Base
    set :session_settings, {
      :key      => SESSION_KEY,
      :secret   => SESSION_SECRET,
    }
    register Sinatra::Extension::Session

    set :github_settings, {
      :client_id              => GITHUB_CLIENT_ID,
      :client_secret          => GITHUB_CLIENT_SECRET,
      :success_callback_url   => "/",
      :success_callback_func  => Proc.new do |access_token|
        # set login session
        session[:login] = {
          :ip => request.ip,
        }
      end
    }
    register Sinatra::Extension::GitHub

    get "/" do
      if is_login?
        haml :home
      else
        haml :index
      end
    end

    post "/logout" do
      session.clear
      redirect "/logout/ok"
    end

    get "/logout/ok" do
      "ログアウトしました"
    end

    helpers do
      def is_login?
        defined?(session[:login][:ip]) &&
          session[:login][:ip] == request.ip
      end
    end
  end
end

