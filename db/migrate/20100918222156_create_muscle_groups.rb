class CreateMuscleGroups < ActiveRecord::Migration
  def self.up
    create_table :muscle_groups do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :muscle_groups
  end
end
