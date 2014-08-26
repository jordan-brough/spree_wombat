require 'active_model/serializer'

module Spree
  module Wombat
    class StoreSerializer < ActiveModel::Serializer
      attributes :name, :code
    end
  end
end
