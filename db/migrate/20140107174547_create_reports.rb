class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references  :account,         null: false
      t.integer     :year,            null: false
      t.integer     :month,           null: false
      t.datetime    :last_modified,   null: false
      t.float       :invoice_total
      t.float       :statement_total
    end

    add_index :reports, [:account_id, :year, :month], unique: true
    add_index :reports, [:year, :month]
  end
end
