require "server/config"
require "sinatra/base"
require "sinatra/ext/session"
require "sinatra/ext/github"
require "sinatra/ext/csrf"

module Server
  class App < Sinatra::Base
    set :session_settings, {
      :key      => SESSION_KEY,
      :secret   => SESSION_SECRET,
    }
    register Sinatra::Extension::Session
    register Sinatra::Extension::Csrf

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

    configure :production, :development do
      set :public_folder, Proc.new { File.join(root, "../../static") }
    end

    get "/" do
      if is_login?
        haml :home
      else
        haml :index
      end
    end

    get "/version" do
      "0.0.0"
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

