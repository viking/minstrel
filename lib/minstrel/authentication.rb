module Minstrel
  class Authentication < Sequel::Model
    many_to_one :user
    many_to_one :identity

    def validate
      super
      validates_presence [:user_id, :identity_id]
    end
  end
end
