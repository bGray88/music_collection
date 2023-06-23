class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.string :title, null: false
      t.integer :create_year, null: false
      t.float :length, null: false

      t.timestamps
    end
  end
end
