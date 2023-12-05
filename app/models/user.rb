class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :otp, presence: true, on: :valid_otp?
  validates :otp, numericality: { only_integer: true }, length: { is: 4 }, on: :valid_otp?

  has_many :questions, dependent: :destroy
  has_many :campus_drives,  dependent: :destroy,class_name: 'CampusDrive'
  has_many :jobs,  dependent: :destroy
  has_many :papers, dependent: :destroy
  has_many :campus_applications,  dependent: :destroy
  has_many :job_applications, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :test_attempts
  has_many :reports, dependent: :destroy
  has_many :user_reports, dependent: :destroy


  enum role: [:student, :admin, :superadmin]
  
  def generate_otp_and_send_email
    otp = generate_random_otp
    self.otp = otp
    self.otp_sent_at = Time.now
    save! 
    OtpMailer.otp_email(self, otp).deliver_later
  end

  def generate_random_otp
    SecureRandom.random_number(10_000).to_s.rjust(4, '0')
  end

  def valid_otp?(otp)
    return false if otp_sent_at < 5.minutes.ago
    self.otp == otp 
  end
end
