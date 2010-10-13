class CreateMusclegroupizations < ActiveRecord::Migration
  def self.up
    create_table :musclegroupizations do |t|
      t.integer :exercise_id
      t.integer :muscle_group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :musclegroupizations
  end
end
