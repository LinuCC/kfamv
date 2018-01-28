class CreateKfSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :kf_songs do |t|
      t.string :title
      t.string :artist

      t.timestamps
    end
  end
end