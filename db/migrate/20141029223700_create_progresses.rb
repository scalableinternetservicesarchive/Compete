class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.string :gain
      t.references :challenge, index: true

      t.timestamps
    end
  end
end
