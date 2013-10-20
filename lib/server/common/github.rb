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
            :name => repo.name,
            :id => repo.id,
          }
        }
      end
    end
  end
end
