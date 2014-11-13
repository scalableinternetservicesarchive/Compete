class AddParticipationToProgress < ActiveRecord::Migration
  def change
    add_reference :progresses, :participation, index: true
  end
end
