module Minstrel
  class Identity < Sequel::Model
    one_to_many :authentications

    def validate
      super
      validates_presence [:uid, :provider]
    end
  end
end
