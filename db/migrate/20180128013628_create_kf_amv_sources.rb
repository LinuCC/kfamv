class CreateKfAmvSources < ActiveRecord::Migration[5.1]
  def change
    create_table :kf_amv_sources do |t|
      t.string :title

      t.timestamps
    end
  end
end
