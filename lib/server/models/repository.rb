require "server/models"
require "server/common"

module Server
  module Models
    class Repository
      include Server::Common
      include Server::Models
      include Mongoid::Document

      field :owner, type: String
      field :name, type: String
      field :reponame, type: String
      has_many :labels

      def self.update_by_reponame github_access_token, github_reponame
        github = GitHub.new github_access_token
        labels = github.get_repo_issues_labels(github_reponame)
        owner_name = github_reponame.match(/(.*)\//)[1]
        repo_name = github_reponame.match(/\/(.*)/)[1]
        collection = find_or_create_by(
          :reponame => github_reponame,
        )
        collection.update_attributes(
          :owner => owner_name,
          :name => repo_name,
        )
        labels.each {|label|
          collection.labels.find_or_create_by(
            :name => label[:name]
          )
          .update_attributes(
            :color => label[:color]
          )
        }
        collection
      end

      def self.get_by_reponame github_access_token, github_reponame
        res = where(
          :reponame => github_reponame,
        ).cache.first
        return update_by_reponame(github_access_token, github_reponame) unless res.owner? && res.name? && res.reponame?
        res
      end

      def self.delete_label! github_access_token, github_reponame, label_name
        repo = where(
          :reponame => github_reponame,
        ).first
        repo.labels.where(
          :name => label_name,
        ).destroy
        github = GitHub.new github_access_token
        github.delete_label! github_reponame, label_name
      end
    end
  end
end

