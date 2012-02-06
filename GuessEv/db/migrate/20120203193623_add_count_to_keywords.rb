class AddCountToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :count, :integer

  end
end
