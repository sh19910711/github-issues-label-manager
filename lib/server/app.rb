require "server/config"
require "server/init"
require "server/common"
require "server/models"
require "server/user_api"
require "server/user_page"
require "server/mock_user_page"
require "sinatra/base"

# Sinatra::Extensions
require "sinatra/ext/session"
require "sinatra/ext/github"
require "sinatra/ext/csrf"
require "sinatra/ext/pjax"

module Server
  class App < Sinatra::Base
    register Server::Init
    register Server::UserAPI
    register Server::UserPage
    register Server::MockUserPage

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
  end
end

