class Employer < ApplicationRecord
  has_many :employer_tasks, dependent: :destroy
  has_many :tasks, through: :employer_tasks

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 50 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
end
