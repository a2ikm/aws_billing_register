class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name,               null: false
      t.string :account_id,         null: false
      t.string :access_key_id,      null: false
      t.string :secret_access_key,  null: false
      t.string :region,             null: false
      t.string :bucket_name,        null: false
    end
  end
end
