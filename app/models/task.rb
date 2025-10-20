class Task < ApplicationRecord
  belongs_to :project
  has_many :employer_tasks, dependent: :destroy
  has_many :employers, through: :employer_tasks
  enum status: {
    # El orden debe coincidir con los IDs lógicos
    active: 0,
    in_progress: 1,
    paused: 2,
    under_review: 3,
    cancelled: 4,
    completed: 5
  }
  enum priority: {
    # El orden debe coincidir con los IDs lógicos
    normal: 0,
    irrelevant: 1,
    important: 2,
    critical: 3
  }

  validates :name, presence: true, length: { minimum: 10, maximum: 300 }
  validates :description, presence: true
  validates :due_date, comparison: { greater_than_or_equal_to: ->(rec) { Date.current } }, allow_nil: true
end
