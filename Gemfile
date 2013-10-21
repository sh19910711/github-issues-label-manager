# A sample Gemfile
source "https://rubygems.org"

ruby "2.0.0"

group :production, :development do
  gem "sinatra"
  gem "sinatra-contrib"
  gem "rack_csrf"
  gem "haml"

  gem "oauth2"
  # gem "addressable"
  gem "octokit"
  gem "mongoid", "~> 3.0.0"
  gem "mongo_ext"
  gem "bson_ext"
end

group :development do
  gem "shotgun"
  gem "byebug"
  gem "pry"
  gem "better_errors"
  gem "binding_of_caller"
  gem "yard"
  gem "yard-sinatra"
end

group :test do
  gem "rake"
  gem "rspec"
end

