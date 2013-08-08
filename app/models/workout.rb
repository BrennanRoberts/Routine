class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :workout_sets, :dependent => :destroy
  has_many :exercises, :through => :workout_sets
  accepts_nested_attributes_for :workout_sets, :allow_destroy => true

  scope :future, -> { where("workouts.date > ?", Date.today).order('date') }
  scope :past, -> { where("workouts.date < ?", Date.today).order('date desc') }
  scope :today, -> { where({:date => Date.today}) }
  scope :complete, -> { where(:complete => true) }
  scope :incomplete, -> { where(:complete => false) }
  scope :forgotten, -> { where("workouts.complete = ? and date < ?", false, Date.today) }

  def muscle_groups
    MuscleGroup.joins(:exercises => :workouts).where(:workouts => {:id => id.to_i}).uniq
  end
end
