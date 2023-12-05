class CampusDrive < ApplicationRecord
  has_many :campus_applications, dependent: :destroy
  belongs_to :test, optional: true
  has_many :papers, through: :test
  has_many :test_attempts, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: true

  after_save :set_report_card_job


  private

  def set_report_card_job
    ReportCardJob.set(wait_until: self.end_date).perform_later(self.id)
  end
end
