require "spec_helper"
require "server/common/github"

describe "T001" do
  before do
    @client = Server::Common::GitHub.new GITHUB_ACCESS_TOKEN
  end
  describe "001: ユーザー" do
    it "001: ユーザーIDが意図したものになっているか" do
      return unless TEST_EYE_GREP_MODE
      puts @client.get_user_id
    end
  end
  describe "002: リポジトリ" do
    it "001: 意図しないリポジトリが取得漏れしていないか" do
      return unless TEST_EYE_GREP_MODE
      p @client.get_repos
    end
  end
  describe "003: Issues" do
    it "001: 指定したリポジトリのIssuesが取得できているか" do
      return unless TEST_EYE_GREP_MODE
      p @client.get_repo_issues "js2ch"
    end
  end
  describe "004: label" do
    it "001: 指定したリポジトリのIssuesのラベルが取得できているか" do
      return unless TEST_EYE_GREP_MODE
      p @client.get_repo_issues_label "js2ch"
    end
  end
  describe "005: API Limit" do
    it "001: 残り回数の確認" do
      return unless TEST_EYE_GREP_MODE
      p @client.get_api_limit
    end
  end
end

