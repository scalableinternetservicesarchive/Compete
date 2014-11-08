class AddCategoryToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :category, :integer
  end
end
