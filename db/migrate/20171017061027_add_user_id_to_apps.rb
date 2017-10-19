class AddUserIdToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :user_id, :integer
  end
end
