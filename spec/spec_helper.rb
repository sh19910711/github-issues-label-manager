require "simplecov"
require "simplecov-rcov"
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

require "rack/test"
require "spork"

GITHUB_ACCESS_TOKEN = ENV["GITHUB_ACCESS_TOKEN"]
TEST_EYE_GREP_MODE = ENV["TEST_EYE_GREP_MODE"] === "TRUE"

require "webmock/rspec"
WebMock.allow_net_connect! if TEST_EYE_GREP_MODE

require "mongoid"
Mongoid.load!("mongoid.yml", :test)

require "database_cleaner"
require "factory_girl"
require "server/models"
FactoryGirl.find_definitions

Spork.prefork do
  RSpec.configure do |config|
    config.include Rack::Test::Methods
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.filter_run :focus
    config.order = 'random'
  end

  RSpec.configure do |config|
    # unknown
    config.before :each do
      stub_request(
        :any,
        /.*/,
      )
      .to_return do |req|
        puts "unknown req: ", req
      end
    end

    # create new label
    config.before :each do
      stub_request(
        :post,
        /repos\/octocat\/gh-repo\/labels$/,
      )
      .to_return do |req|
        params = JSON.parse req.body
        # TODO: use fake gh-labels
        repo = Server::Models::Repository.where(
          :reponame => "octocat/gh-repo",
        ).first
        # create new label
        repo.labels.find_or_create_by(
          :name => params["name"],
        )
        .update_attributes(
          :color => params["color"],
        )
        # send response
        body = {
          "name" => params["name"],
          "color" => params["color"],
        }.to_json
        {
          :status   => 200,
          :body     => body,
          :headers => {
            "Content-Type" => "application/json",
          },
        }
      end
    end

    # update label
    config.before :each do
      stub_request(
        :patch,
        /repos\/octocat\/gh-repo\/labels\/label1$/,
      )
      .to_return do |req|
        params = JSON.parse req.body
        repo = Server::Models::Repository.where(
          :reponame => "octocat/gh-repo"
        ).first
        repo.labels.map {|label|
          if label["name"] == params["name"]
            label["name"] = params["name"]
            label["color"] = params["color"]
          end
          label
        }
        repo.save
        # send response
        body = {
          "name" => params["name"],
          "color" => params["color"],
        }.to_json
        {
          :status   => 200,
          :body     => body,
          :headers => {
            "Content-Type" => "application/json",
          },
        }
      end
    end

    # delete label
    config.before :each do
      stub_request(
        :delete,
        /repos\/octocat\/gh-repo\/labels\/label1$/,
      )
      .to_return do |req|
        params = JSON.parse req.body
        repo = Server::Models::Repository.where(
          :reponame => "octocat/gh-repo"
        ).first
        repo.labels.reject {|label|
          label["name"] == "label1"
        }
        repo.save
        # send response
        {
          :status   => 204,
          :headers => {
            "Content-Type" => "application/json",
          },
        }
      end
    end

    # get labels
    config.before :each do
      stub_request(
        :get,
        /repos\/octocat\/gh-repo\/labels$/,
      )
      .to_return do |req|
        body = Server::Models::Repository.where(
          :reponame => "octocat/gh-repo"
        ).first.labels.to_json
        {
          :status   => 200,
          :body     => body,
          :headers => {
            "Content-Type" => "application/json",
          },
        }
      end
    end

    # get user info
    config.before :each do
      stub_request(
        :get,
        /user$/,
      )
      .to_return do |req|
        body = readmock "api.github.com/user/octocat.json"
        {
          :status   => 200,
          :body     => body,
          :headers => {
            "Content-Type" => "application/json",
          },
        }
      end
    end

    # get user repositories
    config.before :each do
      stub_request(
        :get,
        /users\/octocat\/repos$/,
      )
      .to_return do |req|
        body = readmock "api.github.com/users/octocat/repos.json"
        {
          :status   => 200,
          :body     => body,
          :headers => {
            "Content-Type" => "application/json",
          },
        }
      end
    end

    # client
    config.before { @github = Server::Common::GitHub.new("test-access-token") }
  end

  RSpec.configure do |config|
    config.before do
      FactoryGirl.create :repo1
      FactoryGirl.create :octocat_repo
      FactoryGirl.create :user
    end
    config.after { FactoryGirl.reload }
  end

  RSpec.configure do |config|
    config.before :each do
      require "rack/csrf"
      Rack::Csrf.stub(:csrf_token).and_return("this is token")
    end
  end

  RSpec.configure do |config|
    config.before :suite do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with :truncation
    end
    config.before :each do
      DatabaseCleaner.start
    end
    config.after :each do
      DatabaseCleaner.clean
    end
  end

  # Fake Session
  RSpec.configure do |config|
    config.before do
      session = FakeSessionHash.new
      session[:login] = {
        :ip => "127.0.0.1",
        :github_user_id => "octocat",
        :github_access_token => "ghtoken",
      }
      Rack::Session::Abstract::SessionHash.stub(:new).and_return session
    end
  end

  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
end

Spork.prefork do
  unless ENV['DRB']
    require 'simplecov'
  end
end

Spork.each_run do
  if ENV['DRB']
    require 'simplecov'
  end
end

require "server/app"

class FakeSessionHash < Hash
  def id
    ""
  end
  def options
    {}
  end
end

def source_env path
  File.readlines(path).each do |line|
    values = line.split "="
    ENV[values[0].strip] = values[1].strip
  end
end

def mockpath path
  File.join File.dirname(__FILE__), "/mock/#{path}"
end

def readmock path
  File.read mockpath path
end

