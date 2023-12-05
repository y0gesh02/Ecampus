class Report < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :paper
  belongs_to :test_attempt
end
