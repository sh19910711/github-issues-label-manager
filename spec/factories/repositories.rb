FactoryGirl.define do |f|
  factory :repo1, :class => Server::Models::Repository do
    reponame "user/repo"
    after :create do |a|
      a.labels.create(
        :name => "label1",
        :color => "EEEEEE",
      )
      a.labels.create(
        :name => "label2",
        :color => "EEEEEE",
      )
      a.labels.create(
        :name => "label3",
        :color => "EEEEEE",
      )
      a.labels.create(
        :name => "label4",
        :color => "EEEEEE",
      )
      a.labels.create(
        :name => "label5",
        :color => "EEEEEE",
      )
      a.labels.create(
        :name => "label6",
        :color => "EEEEEE",
      )
    end
  end
  factory :octocat_repo, :class => Server::Models::Repository do
    reponame "octocat/gh-repo"
    after :create do |a|
      a.labels.create(
        :name => "label6",
        :color => "CCCCCC",
      )
      a.labels.create(
        :name => "label1",
        :color => "CCCCCC",
      )
    end
  end
end
