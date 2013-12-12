class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.integer :user_id
      t.integer :journable_id
      t.string :jounerable_type
      t.text :text

      t.timestamps
    end
  end
end
