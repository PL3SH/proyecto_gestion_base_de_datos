class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  enum :status,  { active: 0, in_progress: 1, paused: 2, under_review: 3, cancelled: 4, completed: 5 }



end
