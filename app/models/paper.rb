class Paper < ApplicationRecord
  validates :name, presence: true
  validates :total_marks, presence: true, numericality: { greater_than: 0 }
  validates :duration_in_minutes, presence: true, numericality: { greater_than: 0 }
  validates :passing_marks, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  has_and_belongs_to_many :questions
  belongs_to :user
  has_and_belongs_to_many :tests
end
