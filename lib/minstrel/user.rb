module Minstrel
  class User < Sequel::Model
    one_to_many :authentications

    def validate
      super
      validates_presence :name
      validates_unique :name
    end
  end
end
