class AddRatingToTitles < ActiveRecord::Migration
  def change
    add_column :titles, :rating, :float
  end
end
