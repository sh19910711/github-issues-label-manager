require "mongoid"

module Server
  module Models
    class User
      include Mongoid::Document
      field :github_user_id
      field :github_access_token
    end
  end
end
