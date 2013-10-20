require "mongoid"

module Server
  module Models
    class User
      include Mongoid::Document
      field :github_user_id, type: String
      field :github_access_token, type: String
    end
  end
end
