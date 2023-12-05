class TestAttempt < ApplicationRecord
  belongs_to :test
  belongs_to :campus_drive,optional: true
  belongs_to :job,optional: true
  belongs_to :user
  has_many :reports, dependent: :destroy
  has_one :user_report, dependent: :destroy



  def set_status_job(current_user, campus_drive)
    if submitted_at.present?
      StatusChangeJob.perform_later(current_user, campus_drive)
    end
  end
end
