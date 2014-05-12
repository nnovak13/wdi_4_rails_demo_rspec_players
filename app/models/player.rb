class Player < ActiveRecord::Base
  JOBS = %w(Knight Wizard Cleric Rogue)
  validates :name, :job, :health, :magic, presence: true
  validates :name, uniqueness: true
  validates :job, inclusion: { in: JOBS }
end
