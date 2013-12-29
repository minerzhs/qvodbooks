class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :book
      t.references :user
      t.date :check_out_date
      t.date :check_in_date
      t.timestamps
    end
    add_index :records, :book_id
    add_index :records, :user_id
  end
end
