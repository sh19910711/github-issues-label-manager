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

      #
      # User Repos
      #
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

      #
      # Repo Labels
      #
      app.put "/api/labels/:github_user_id/:github_repo_name" do
        require_get_csrf do
          require_login do
            Labels.update_by_reponame(
              login_user.github_access_token,
              "#{params[:github_user_id]}/#{params[:github_repo_name]}",
            )
            labels = Labels.get_by_reponame(
              login_user.github_access_token,
              "#{params[:github_user_id]}/#{params[:github_repo_name]}",
            )
            labels = labels.labels.map do |label|
              {
                :id => "#{labels.reponame}/#{label["name"]}",
                :name => label["name"],
                :color => label["color"],
              }
            end
            labels.to_json
          end
        end
      end

      app.get "/api/labels/:github_user_id/:github_repo_name" do
        require_login do
          halt 403 if login_user.github_user_id != params[:github_user_id]
          labels = Labels.get_by_reponame(
            login_user.github_access_token,
            "#{params[:github_user_id]}/#{params[:github_repo_name]}",
          )
          labels = labels.labels.map do |label|
            {
              :id => "#{labels.reponame}/#{label["name"]}",
              :name => label["name"],
              :color => label["color"],
            }
          end
          labels.to_json
        end
      end

      #
      # Repo Label
      #

      # Create Label
      app.post "/api/label" do
        request.body.rewind
        params_json = JSON.parse request.body.read
        params[:csrf_token] = params_json["csrf_token"]
        require_get_csrf do
          require_login do
            label_info = {
              :name => params_json["name"],
              :color => params_json["color"],
            }
            github = GitHub.new login_user.github_access_token
            github.add_label(
              "#{params_json["github_user_id"]}/#{params_json["github_repo_name"]}",
              label_info,
            )
            Labels.update_by_reponame(
              login_user.github_access_token,
              "#{params_json["github_user_id"]}/#{params_json["github_repo_name"]}",
            )
            return {
              :result => "OK",
            }.to_json
          end
          return {
            :result => "NG",
          }.to_json
        end
      end

      # Update Label
      app.put "/api/label/:label_id" do
        matches          = params[:label_id].match /([^\/]*)\/([^\/]*)\/([^\/]*)/
        github_user_id   = matches[1]
        github_repo_name = matches[2]
        label_name       = matches[3]
        request.body.rewind
        params_json = JSON.parse request.body.read
        params[:csrf_token] = params_json["csrf_token"]
        require_get_csrf do
          require_login do
            label_info = {
              :name => params_json["name"],
              :color => params_json["color"],
            }
            # change github data
            github = GitHub.new login_user.github_access_token
            github.update_label(
              "#{github_user_id}/#{github_repo_name}",
              label_name,
              {
                :name => params_json["name"],
                :color => params_json["color"],
              },
            )
            # change model data
            repo_labels = Labels.where(
              :reponame => "#{github_user_id}/#{github_repo_name}",
            ).first
            repo_labels.labels.map {|label|
              if label["name"] == label_name
                label["name"] = params_json["name"]
                label["color"] = params_json["color"]
              end
              label
            }
            repo_labels.save
            # send result
            return {
              :result => "OK",
            }.to_json
          end
        end
        return {
          :result => "NG",
        }.to_json
      end

      # Get Label
      app.get "/api/label/:label_id" do
        matches          = params[:label_id].match /([^\/]*)\/([^\/]*)\/([^\/]*)/
        github_user_id   = matches[1]
        github_repo_name = matches[2]
        label_name       = matches[3]
        repo_labels = Labels.where(
          :reponame => "#{github_user_id}/#{github_repo_name}",
        ).cache.first
        label1 = repo_labels.labels.select{|label| label["name"] == label_name }.first
        {
          :id => params["label_id"],
          :name => label1["name"],
          :color => label1["color"],
        }.to_json
      end

      # Delete label
      app.delete "/api/label/:label_id" do
        request.body.rewind
        params_json = JSON.parse request.body.read
        params[:csrf_token] = params_json["csrf_token"]
        require_get_csrf do
          require_login do
            matches          = params[:label_id].match /([^\/]*)\/([^\/]*)\/([^\/]*)/
            github_user_id   = matches[1]
            github_repo_name = matches[2]
            label_name       = matches[3]
            Labels.delete_label!(
              login_user.github_access_token,
              "#{github_user_id}/#{github_repo_name}",
              label_name,
            )
            return {
              :result => "OK",
            }.to_json
          end
          return {
            :result => "NG",
          }.to_json
        end
      end
    end
  end
end
