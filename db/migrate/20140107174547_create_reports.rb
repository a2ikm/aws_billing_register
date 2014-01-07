class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references  :account,       null: false,  index: true
      t.integer     :year,          null: false
      t.integer     :month,         null: false
      t.datetime    :last_modified, null: false
    end
  end
end
