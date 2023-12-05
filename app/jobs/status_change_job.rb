class StatusChangeJob < ApplicationJob
  queue_as :default

  def perform(user, campus_drive)
    campus_application = campus_drive.campus_applications.find_by(user_id: user.id)
    if campus_application
      campus_application.update(status: "Test Attempted")
    else
      Rails.logger.error("Campus application not found for user #{user.id} and campus drive #{campus_drive.id}")
    end
  end
end


