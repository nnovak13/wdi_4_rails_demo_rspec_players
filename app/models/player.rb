class Player < ActiveRecord::Base
  validates :name, :job, :health, :magic, presence: true
end
