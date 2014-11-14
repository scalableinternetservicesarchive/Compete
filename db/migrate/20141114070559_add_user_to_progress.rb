class AddUserToProgress < ActiveRecord::Migration
  def change
    add_reference :progresses, :user, index: true
  end
end
