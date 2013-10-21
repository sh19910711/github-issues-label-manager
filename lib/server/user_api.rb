require "server/common"
require "server/models"

module Server
  module UserAPI
    include Server::Common
    include Server::Models

    def self.registered app
      app.post "/api/get_new_repos" do
        require_login do
          github = GitHub.new login_user.github_access_token
          repos_json = github.get_repos.to_json
          login_user.update_attributes(
            :github_repos_json => repos_json,
          )
          repos_json
        end
      end

      app.post "/api/get_repo_labels" do
        require_login do
          [].to_json
        end
      end

      app.post "/api/get_new_issues_labels" do
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

      app.post "/api/get_issues_labels" do
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
