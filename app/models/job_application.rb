class JobApplication < ApplicationRecord
  before_create :generate_uuid
  
  belongs_to :user
  belongs_to :job

  validates_uniqueness_of :user_id, scope: :job_id
  validates :status, inclusion: { in: ['Application Submitted', 'Test Attempted','Rejected', 'Selected'] }

  scope :already_registered_job, ->(user_id, job_id) do
    where(user_id: user_id, job_id: job_id)
  end


  private

  def generate_uuid
    self.applicant_id = SecureRandom.random_number(10_000_000..99_999_999)
  end
end
