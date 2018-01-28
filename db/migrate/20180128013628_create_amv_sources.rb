class CreateAmvSources < ActiveRecord::Migration[5.1]
  def change
    create_table :amv_sources do |t|
      t.string :title

      t.timestamps
    end
  end
end
