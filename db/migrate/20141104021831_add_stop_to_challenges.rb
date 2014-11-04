class AddStopToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :stop, :date
  end
end
