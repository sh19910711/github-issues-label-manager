require "server/models"
require "server/common"

module Server
  module Models
    class Repository
      include Server::Common
      include Server::Models
      include Mongoid::Document

      field :reponame
      has_many :labels

      def self.update_by_reponame github_access_token, github_reponame
        github = GitHub.new github_access_token
        labels = github.get_repo_issues_labels(github_reponame)
        find_or_create_by(
          :reponame => github_reponame,
        )
        collections = where(
          :reponame => github_reponame,
        ).cache.first
        labels.each {|label|
          collections.labels.find_or_create_by(
            :name => label[:name]
          )
          .update_attributes(
            :color => label[:color]
          )
        }
        collections
      end

      def self.get_by_reponame github_access_token, github_reponame
        res = where(
          :reponame => github_reponame,
        ).cache.first
        return update_by_reponame(github_access_token, github_reponame) if res.nil?
        res
      end

      def self.delete_label! github_access_token, github_reponame, label_name
        labels = where(
          :reponame => github_reponame,
        ).first
        labels.labels.where(
          :name => label_name,
        ).destroy
        github = GitHub.new github_access_token
        github.delete_label! github_reponame, label_name
      end
    end
  end
end

