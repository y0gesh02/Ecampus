class Question<ApplicationRecord
  validates :question, presence: true
  validates :question_type, inclusion: { in: ['objective', 'answer'] }

  # For objective type questions
  validates :options, presence: true, if: -> { question_type == 'objective' }
  validates :correct_answer, presence: true, if: -> { question_type == 'objective' }

  validates :answer, presence: true, if: -> { question_type == 'answer' }

  # Additional attributes for objective type questions
  serialize :options,Array, if: -> { question_type == 'objective' }

  has_and_belongs_to_many :papers
  belongs_to :user
end
