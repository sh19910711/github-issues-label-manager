require "spec_helper"
require "server/common/github"

describe "T001" do
  describe "001: ユーザー" do
    it "001: ユーザーIDが意図したものになっているか" do
      puts @github.get_user_id if TEST_EYE_GREP_MODE
    end
  end
  describe "002: リポジトリ" do
    it "001: 意図しないリポジトリが取得漏れしていないか" do
      p @github.get_repos if TEST_EYE_GREP_MODE
    end
  end
  describe "003: Issues" do
    it "001: 指定したリポジトリのIssuesが取得できているか" do
      p @github.get_repo_issues "js2ch" if TEST_EYE_GREP_MODE
    end
  end
  describe "004: label" do
    it "001: 指定したリポジトリのIssuesのラベルが取得できているか" do
      p @github.get_repo_issues_label "js2ch" if TEST_EYE_GREP_MODE
    end
  end
  describe "005: API Limit" do
    it "001: 残り回数の確認" do
      p @github.get_api_limit if TEST_EYE_GREP_MODE
    end
  end
end

