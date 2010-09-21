class AddMuscleGroupToMuscle < ActiveRecord::Migration
  def self.up
    add_column :muscles, :muscle_group_id, :integer
  end

  def self.down
    remove_column :muscles, :muscle_group_id
  end
end
