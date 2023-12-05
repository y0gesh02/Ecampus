class ReportCardJob < ApplicationJob
  queue_as :default

  def perform(campus_drive_id)
    campus_drive = CampusDrive.find(campus_drive_id)
    
    if campus_drive.test_attempts.present?
      GenerateUserReportJob.perform_later(campus_drive_id)

      campus_drive.test_attempts.each do |test_attempt|
        ResultMailer.result_mail(test_attempt).deliver_later
      end
    else
      Rails.logger.info("No test attempts for Campus Drive ##{campus_drive.id}")
    end  
  end
end


