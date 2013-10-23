FactoryGirl.define do
  factory :labels, :class => Server::Models::Labels do
    reponame "user/repo"
    labels [
      {
        :name => "label2",
        :color => "EEEEEE",
      },
      {
        :name => "label3",
        :color => "EEEEEE",
      },
      {
        :name => "label4",
        :color => "EEEEEE",
      },
      {
        :name => "label5",
        :color => "EEEEEE",
      },
      {
        :name => "label1",
        :color => "EEEEEE",
      },
      {
        :name => "label6",
        :color => "EEEEEE",
      },
    ]
  end
end
