require "spec_helper"

describe "T003: User API" do
  def app
    Server::App.new
  end

  describe "001: Label" do
    describe "001: Create" do
      before do
        post(
          "/api/label",
          {
            "csrf_token" => "this is token",
            "github_user_id" => "octocat",
            "github_repo_name" => "gh-repo",
            "name" => "new-label1",
            "color" => "ffffff",
          }.to_json,
          {},
        )
      end
      it "001: Check Created" do
        repo = Server::Models::Repository.where(
          :reponame => "octocat/gh-repo",
        ).first.labels.where({:name => "new-label1"}).first
        repo.color.should eq "ffffff"
      end
    end

    describe "002: Read" do
      before { get "/api/label/#{CGI.escape("user/repo/label1")}" }
      subject { JSON.parse(last_response.body)["color"] }
      it "001: Read" do
        should eq "EEEEEE"
      end
    end

    describe "003: Update" do
      before do
        put(
          "/api/label/#{CGI.escape("octocat/gh-repo/label1")}",
          {
            "csrf_token" => "this is token",
            "name" => "new-label1",
            "color" => "C0FFEE",
          }.to_json,
          {},
        )
      end
      it "001: Check Updated" do
        repo = Server::Models::Repository.where(
          :reponame => "octocat/gh-repo"
        ).first
        repo.labels.where(:name => "label1").count.should eq 0
        repo.labels.where(:name => "new-label1").count.should eq 1
        repo.labels.each {|label|
          if label.name == "new-label1"
            label.color.should eq "C0FFEE"
          end
        }
      end
    end

    describe "004: Delete" do
      before do
        delete(
          "/api/label/#{CGI.escape("octocat/gh-repo/label1")}",
          {
            "csrf_token" => "this is token",
          }.to_json,
          {},
        )
      end
      it "001: Check Deleted" do
        repo = Server::Models::Repository.where(
          :reponame => "octocat/gh-repo"
        ).first
        repo.labels.where(:name => "label1").count.should eq 0
      end
    end
  end
end
