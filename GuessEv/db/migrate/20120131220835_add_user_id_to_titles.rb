class AddUserIdToTitles < ActiveRecord::Migration
  def change
    add_column :titles, :user_id, :integer

  end
end
