class AddNameToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :name, :string

  end
end
