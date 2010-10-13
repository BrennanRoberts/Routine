class RemoveMuscles < ActiveRecord::Migration
  def self.up
  	drop_table :exercises_muscles
  	drop_table :muscles
  end

  def self.down
  	create_table :muscles do |t|
  		t.string :name
  		t.integer :muscle_group_id
  		
	  	t.timestamps
	  end
	  
	  create_table :exercises_muscles do |t|
	  	t.integer :exercise_id
	  	t.integer :muscle_id
	  end
  end
end
