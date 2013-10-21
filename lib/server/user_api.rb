require "server/common"
require "server/models"

module Server
  module UserAPI
    include Server::Common
    include Server::Models

    def self.registered app
      app.put "/api/repos/:github_user_id" do
        require_login do
          github = GitHub.new login_user.github_access_token
          repos_json = github.get_repos.to_json
          login_user.update_attributes(
            :github_repos_json => repos_json,
          )
          repos_json
        end
      end

      app.get "/api/repos/:github_user_id" do
        require_get_csrf do
          require_login do
            github = GitHub.new login_user.github_access_token
            repos_json = github.get_repos.to_json
            login_user.update_attributes(
              :github_repos_json => repos_json,
            )
            repos_json
          end
        end
      end

      app.put "/api/issues_labels/:github_user_id/:github_repo_name" do
        require_login do
          IssuesLabels.update_by_reponame(
            login_user.github_access_token,
            "#{params[:github_user_id]}/#{params[:github_repo_name]}",
          )
          issues_labels = IssuesLabels.get_by_reponame(
            login_user.github_access_token,
            "#{params[:github_user_id]}/#{params[:github_repo_name]}",
          )
          issues_labels.labels.to_json
        end
      end

      app.get "/api/issues_labels/:github_user_id/:github_repo_name" do
        require_get_csrf do
          require_login do
            halt 403 if login_user.github_user_id != params[:github_user_id]
            issues_labels = IssuesLabels.get_by_reponame(
              login_user.github_access_token,
              "#{params[:github_user_id]}/#{params[:github_repo_name]}",
            )
            issues_labels.labels.to_json
          end
        end
      end
    end
  end
end
