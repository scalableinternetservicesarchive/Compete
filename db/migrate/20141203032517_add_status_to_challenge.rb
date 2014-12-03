class AddStatusToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :status, :integer
  end
end
