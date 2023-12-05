class Users::OtpSessionsController < Devise::SessionsController
  def new_otp
    if user_signed_in?
      redirect_to root_path, alert: "You are already signed in. Please sign out to use OTP login."
    end
    render :new_otp
  end

  def send_otp
    user = User.find_by(email: params[:email])
    if user
      user.generate_otp_and_send_email # Implement this method to generate and send OTP
      flash[:notice] = "OTP sent to your email. Please check your inbox."
      render 'verify_otp_view',params: { email: @email }
    else
      flash[:alert] = "User not found."
      redirect_to otp_email_path
    end
  end

  def verify_otp_view
  end

  def verify_otp
    @user = User.find_by(email: params[:email])
    @email = params[:email]
    if @user && @user.valid_otp?(params[:otp])
      sign_in(@user)
      redirect_to root_path, notice: "Logged in successfully with OTP"
    else
      redirect_to otp_login_path(email: @user.email), alert: "Invalid OTP"
    end
  end

  def resend_otp
    user = User.find_by(email: params[:email])
    if user
      if user.otp_sent_at < 1.minute.ago
        user.generate_otp_and_send_email
        flash[:notice] = "OTP has been resent to your email."
      else
        flash.now[:alert] = "You have already received an OTP recently. Please check your email."
      end
    else
      flash.now[:alert] = "User not found. Please enter a valid email."
    end
    render 'verify_otp_view', params: { email: params[:email] }
  end
end

