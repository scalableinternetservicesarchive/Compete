class AddSportToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :sport, :integer
    add_column :challenges, :distance, :integer
  end
end
