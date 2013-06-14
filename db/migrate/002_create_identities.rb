Sequel.migration do
  up do
    create_table :identities do
      primary_key :id
      String :uid
      String :provider
    end
  end
end
