class Job < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: ['active', 'expired'] }
  validates :company_name, presence: true
  validates :contact_info, presence: true
  
  has_many :job_applications, dependent: :destroy
  belongs_to :test, optional: true
  has_many :papers, through: :test
  has_many :test_attempts
  belongs_to :user
end
