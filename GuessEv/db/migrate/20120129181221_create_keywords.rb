class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|

      t.timestamps
    end
  end
end
