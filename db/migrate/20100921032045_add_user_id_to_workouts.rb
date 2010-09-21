class AddUserIdToWorkouts < ActiveRecord::Migration
  def self.up
    add_column :workouts, :user_id, :integer
  end

  def self.down
    remove_column :workouts, :user_id
  end
end
