class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references :user,  null: false, foreign_key: true
      t.string :user_image, null: false

      t.timestamps
    end
  end
end
