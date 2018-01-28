class CreateAmvPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :kf_amv_posts do |t|
      t.references :post, foreign_key: {to_table: :thredded_posts}

      t.timestamps
    end
  end
end
