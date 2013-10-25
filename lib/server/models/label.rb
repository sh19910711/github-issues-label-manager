require "server/common"

module Server
  module Models
    class Label
      include Server::Common
      include Mongoid::Document

      field :name, type: String
      field :color, type: String
      belongs_to :repository
    end
  end
end
