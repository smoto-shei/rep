class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.string :en_name
      t.string :ja_name

      t.timestamps
    end
    
    add_index :exercises, :en_name
    add_index :exercises, :ja_name
  end
end
