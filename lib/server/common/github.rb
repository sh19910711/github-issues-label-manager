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
    end
  end
end
