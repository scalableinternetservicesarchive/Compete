class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.integer :gain
      t.references :challenge, index: true

      t.timestamps
    end
  end
end
