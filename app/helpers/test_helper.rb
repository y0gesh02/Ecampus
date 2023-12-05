module TestHelper

  def total_time_and_marks(papers)
    total_time = papers.sum(&:duration_in_minutes)
    total_marks = papers.sum(&:total_marks)
    passing_marks = papers.sum(&:passing_marks)

    [total_time, total_marks,passing_marks]
  end
end
