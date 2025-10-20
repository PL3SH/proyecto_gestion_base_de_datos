class EmployerTask < ApplicationRecord
  belongs_to :employer
  belongs_to :task

  validates :employer_id, presence: true
  validates :task_id, presence: true
end
