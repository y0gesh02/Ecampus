class UserReport < ApplicationRecord
  belongs_to :user
  belongs_to :test_attempt

  validates :total_score, presence: true

end
