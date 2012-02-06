class AddNameToTitles < ActiveRecord::Migration
  def change
    add_column :titles, :name, :string

  end
end
