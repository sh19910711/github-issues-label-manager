require "server/config"
require "server/common"
require "server/models"

module Server
  module Init
    include Server::Models
    def self.registered app
      app.helpers Server::Common::Helpers

      # Session
      app.set :session_settings, {
        :key      => SESSION_KEY,
        :secret   => SESSION_SECRET,
      }
      app.register Sinatra::Extension::Session

      app.register Sinatra::Extension::Csrf
      app.register Sinatra::Extension::Pjax

      # GitHub
      app.set :github_settings, {
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
          user.update_attributes(
            :github_user_id => github_user_id,
            :github_access_token => session[:github_access_token],
            :github_api_limit => github.get_api_limit.limit,
            :github_api_remaining => github.get_api_limit.remaining,
          )
          # set login session
          session[:login] = {
            :ip => request.ip,
            :github_user_id => github_user_id,
          }
        end
      }
      app.register Sinatra::Extension::GitHub
    end
  end
end
