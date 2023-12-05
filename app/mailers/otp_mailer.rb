class OtpMailer < ApplicationMailer
  default from: 'yogesh.sakle@test.com'

  def otp_email(user, otp)
    @user = user
    @otp = otp
    mail(to: @user.email, subject: 'Hey Here is Your Login OTP')
  end
end
