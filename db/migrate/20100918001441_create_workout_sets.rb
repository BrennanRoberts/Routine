class CreateWorkoutSets < ActiveRecord::Migration
  def self.up
    create_table :workout_sets do |t|
      t.integer :workout_id
      t.integer :exercise_id
      t.integer :order
      t.integer :magnitude
      t.integer :measurement_unit_id
      t.integer :weight

      t.timestamps
    end
  end

  def self.down
    drop_table :workout_sets
  end
end
