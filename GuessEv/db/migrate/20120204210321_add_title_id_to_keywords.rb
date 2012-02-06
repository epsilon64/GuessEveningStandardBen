class AddTitleIdToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :title_id, :string

    add_column :keywords, :integer, :string

  end
end
