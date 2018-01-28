class AddAdminToKfUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :kf_users, :admin, :boolean, null: false, default: false
  end
end
