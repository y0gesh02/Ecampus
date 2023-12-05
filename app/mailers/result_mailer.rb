class ResultMailer < ApplicationMailer
  default from: 'yogesh.sakle@test.com'

  def result_mail(test_attempt)
    @user = test_attempt.user
    @user_report = test_attempt.user_report
    @test_attempt = test_attempt
    mail(to: @user.email, subject: 'Hey Here is Your Report Card')
  end
end
