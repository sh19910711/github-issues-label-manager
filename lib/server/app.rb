require "server/config"
require "server/common"
require "server/models"
require "sinatra/base"

# Sinatra::Extensions
require "sinatra/ext/session"
require "sinatra/ext/github"
require "sinatra/ext/csrf"
require "sinatra/ext/pjax"

module Server
  class App < Sinatra::Base
    include Server::Models
    set :session_settings, {
      :key      => SESSION_KEY,
      :secret   => SESSION_SECRET,
    }
    register Sinatra::Extension::Session
    register Sinatra::Extension::Csrf
    register Sinatra::Extension::Pjax

    set :github_settings, {
      :client_id              => GITHUB_CLIENT_ID,
      :client_secret          => GITHUB_CLIENT_SECRET,
      :success_callback_url   => "/",
      :success_callback_func  => Proc.new do
        github = Server::Common::GitHub.new session[:github_access_token]
        github_user_id = github.get_user_id
        # set github user info
        selected = User.where(:github_user_id => github_user_id).cache
        session[:first_login] = selected.count == 0
        user = User.find_or_create_by(
          :github_user_id => github_user_id,
        )
        user.update(
          :github_user_id => github_user_id,
          :github_access_token => session[:github_access_token],
        )
        # set login session
        session[:login] = {
          :ip => request.ip,
          :github_user_id => github_user_id,
        }
      end
    }
    register Sinatra::Extension::GitHub

    configure :production, :development do
      set :public_folder, Proc.new { File.join(root, "../../static") }
    end

    get "/" do
      if is_login?
        haml_pjax :user_home
      else
        haml_pjax :index
      end
    end

    get "/about" do
      haml_pjax :about_app
    end

    get "/version" do
      require_login do
        haml_pjax :version
      end
    end

    get "/repos" do
      haml_pjax :user_repos
    end

    post "/logout" do
      session.clear
      redirect "/"
    end

    helpers do
      def is_login?
        defined?(session[:login][:ip]) &&
          session[:login][:ip] == request.ip
      end

      def partial view
        haml view
      end

      def require_login &block
        redirect "/" unless is_login?
        yield
      end
    end
  end
end

