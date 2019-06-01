class CreateUserBodies < ActiveRecord::Migration[5.2]
  def change
    create_table :user_bodies do |t|
      t.references :user,  null: false, foreign_key: true
      t.integer :weight
      t.integer :height
      t.string :gender
      t.integer :birth_year
      t.timestamps
    end
  end
end
