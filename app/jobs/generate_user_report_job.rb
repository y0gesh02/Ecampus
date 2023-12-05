class GenerateUserReportJob < ApplicationJob
  queue_as :critical

  def perform(campus_drive_id)
    campus_drive = CampusDrive.find(campus_drive_id)

    campus_drive.test_attempts.each do |test_attempt|
      generate_report(test_attempt)
    end
  end

  
  private

  def generate_report(test_attempt)
    total_score = test_attempt.total_score

    UserReport.create(
      user: test_attempt.user,
      test_attempt: test_attempt,
      total_score: total_score,
      campus_drive: test_attempt.campus_drive
    )
  end
end
