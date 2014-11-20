class AddStatusToParticipation < ActiveRecord::Migration
  def change
    add_column :participations, :status, :integer
  end
end
