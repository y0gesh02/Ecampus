class Test < ApplicationRecord
  has_many :campus_drives
  has_many :jobs
  belongs_to :user       
  has_and_belongs_to_many :papers
  has_many :test_attempts
end
