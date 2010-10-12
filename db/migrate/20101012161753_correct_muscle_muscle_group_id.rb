class CorrectMuscleMuscleGroupId < ActiveRecord::Migration
	def self.up
		remove_column :muscles, :muscle_group_id
		add_column :muscles, :muscle_group_id, :integer
	end

  def self.down
    remove_column :muscles, :muscle_group_id
    add_column :muscles, :muscle_group_id, :integer
  end
  
end
