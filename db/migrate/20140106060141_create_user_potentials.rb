class CreateUserPotentials < ActiveRecord::Migration
  def change
    create_table :user_potentials do |t|
      t.string :email

      t.timestamps
    end
  end
end
