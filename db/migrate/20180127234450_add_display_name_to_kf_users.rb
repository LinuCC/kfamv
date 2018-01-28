class AddDisplayNameToKfUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :kf_users, :display_name, :string, null: false
    DbTextSearch::CaseInsensitive.add_index connection, :kf_users, :display_name,
                                            unique: true
  end
end
