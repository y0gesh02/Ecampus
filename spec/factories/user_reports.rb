FactoryBot.define do
  factory :user_report do
    user { nil }
    test_attempt { nil }
    total_score { 1 }
    question { "MyText" }
    user_answer { "MyText" }
  end
end
