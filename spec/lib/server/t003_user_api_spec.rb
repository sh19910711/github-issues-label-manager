require "spec_helper"

describe "T003: User API" do
  def app
    Server::App
  end

  describe "001: Label" do
    it "001: Create" do
      puts "Hello create"
    end

    describe "002: Read" do
      before { get "/api/label/#{CGI.escape("user/repo/label1")}" }
      subject { JSON.parse(last_response.body)["color"] }
      it "002: Read" do
        should eq "EEEEEE"
      end
    end

    it "003: Update" do raise "TODO" end
    it "004: Delete" do raise "TODO" end
  end
end
