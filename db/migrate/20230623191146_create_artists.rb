class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :api_id, null: false, index: { unique: true }
      t.string :image

      t.timestamps
    end
  end
end
