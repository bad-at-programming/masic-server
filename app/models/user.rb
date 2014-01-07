class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation
  after_create :generate_api_key

  has_many :songs

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64
    self.save
  end
end
