class CreateTitleKeywordJoinTable < ActiveRecord::Migration
def up
	create_table :keywords_titles, :id => false do |t|
	  t.integer :keyword_id
	  t.integer :title_id
	end
end

  def down
	drop_table :keywords_titles
  end
end
