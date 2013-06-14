Sequel.migration do
  up do
    create_table :authentications do
      primary_key :id
      foreign_key :user_id, :users
      foreign_key :identity_id, :identities
    end
  end
end
