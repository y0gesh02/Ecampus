# Preview all emails at http://localhost:3000/rails/mailers/result_mailer
class ResultMailerPreview < ActionMailer::Preview
    def result_mail
        @user = User.find(11)
        @test_attempt= TestAttempt.find(37)
        ResultMailer.with(user: User.find(11),test_attempt: TestAttempt.find(37)).result_mail(@user, @test_attempt)
    end
end
