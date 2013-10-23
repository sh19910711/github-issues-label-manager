require "spec_helper"

describe "T003: User API" do
  def app
    Server::App
  end

  describe "001: Label" do
    it "001: Create" do raise "TODO" end

    describe "002: Read" do
      before { get "/api/label/#{CGI.escape("user/repo")}" }
      it "002: Read" do
        puts last_response.body
        @github.get_user_id.should === "octocat"
      end
    end

    it "003: Update" do raise "TODO" end
    it "004: Delete" do raise "TODO" end
  end
end
