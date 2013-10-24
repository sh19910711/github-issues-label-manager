FactoryGirl.define do
  factory :user, :class => Server::Models::User do
    github_user_id "octocat"
    github_access_token "ghtoken"
  end
end
