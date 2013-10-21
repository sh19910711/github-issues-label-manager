module Server
  module UserPage
    def self.registered app
      app.get "/version" do
        require_login do
          return haml_pjax :version
        end
      end

      app.get "/user_status" do
        require_login do
          @user = login_user
          return haml_pjax :user_status
        end
      end

      app.post "/api/get_repos" do
        require_login do
          return login_user.github_repos_json
        end
      end

      app.get "/repos" do
        require_login do
          haml_pjax :user_repos
        end
      end

      app.get "/repos/:github_user_id/:github_repo_name" do
        require_login do
          halt 403 unless login_user[:github_user_id] === params[:github_user_id]
          @github_user_id = params[:github_user_id]
          @github_repo_name = params[:github_repo_name]
          haml_pjax :user_repo
        end
      end

      app.post "/logout" do
        require_login do
          session.clear
          redirect "/"
        end
      end
    end
  end
end
