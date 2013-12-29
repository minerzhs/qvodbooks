class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :isbn
      t.string :recommended_by
      t.string :status
      t.date :arrive_date
      t.text :note

      t.timestamps
    end
    add_index :books, :isbn
  end
end