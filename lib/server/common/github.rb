require "octokit"

module Server
  module Common
    class GitHub
      def initialize access_token
        @client = Octokit::Client.new(
          :access_token => access_token,
        )
      end

      def get_user_id
        @client.user.login
      end

      def get_repos
        @client.user.rels[:repos].get.data.map {|repo|
          {
            :full_name => repo.full_name,
            :name      => repo.name,
            :id        => repo.id,
          }
        }
      end

      # Ex: repo -> user/repo
      def resolve_reponame reponame
        selected_1 = get_repos.select {|cand|
          cand[:full_name] === "#{reponame}"
        }
        return selected_1[0][:full_name] if selected_1.length == 1
        selected_2 = get_repos.select {|cand|
          cand[:full_name].end_with? "/#{reponame}"
        }
        p selected_2
        p reponame
        abort "error" if selected_2.length != 1
        selected_2[0][:full_name]
      end

      def get_repo_issues reponame
        issues = @client.list_issues(
          resolve_reponame(reponame),
          {
            :state => "open",
          },
        ).map {|issue|
          {
            :number => issue.number,
            :title => issue.title,
          }
        }
        issues
      end

      def get_repo_issues_labels reponame
        @client.labels(resolve_reponame(reponame)).map {|label|
          {
            :name => label.name,
            :color => label.color,
          }
        }
      end

      def get_api_limit
        @client.ratelimit
      end

      def add_label reponame, label_info
        @client.add_label resolve_reponame(reponame), label_info[:name], label_info[:color]
      end

      def delete_label! reponame, label_name
        @client.delete_label! reponame, label_name
      end
    end
  end
end
