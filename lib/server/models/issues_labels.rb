require "server/common"

module Server
  module Models
    class IssuesLabels
      include Server::Common
      include Mongoid::Document

      field :reponame
      field :labels, type: Array

      def self.update_by_reponame github_access_token, github_reponame
        github = GitHub.new github_access_token
        labels = github.get_repo_issues_labels(github_reponame)
        find_or_create_by(
          :reponame => github_reponame,
        ).update_attributes(
          :labels => labels,
        )
        where(
          :reponame => github_reponame,
        ).cache.first
      end

      def self.get_by_reponame github_access_token, github_reponame
        res = where(
          :reponame => github_reponame,
        ).cache.first
        return update_by_reponame(github_access_token, github_reponame) if res.nil?
        res
      end
    end
  end
end

