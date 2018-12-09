class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]
  mount_uploader :photo, PhotoUploader

  has_many :orders
  has_many :carts, dependent: :nullify
  has_one :cart, -> { where(active: true) }
  has_many :cart_items, through: :cart
  has_many :addresses, dependent: :destroy

  validates_confirmation_of :password

  after_create :send_welcome_email

  scope :not_guests, -> { where(guest: false)}

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h
    # user_params[:email] = "#{user_params[:uid]}@facebook.com" if user_params[:email].blank?
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end
    return user
  end

  def full_name
    if self.first_name && self.last_name
      return "#{self.first_name} #{self.last_name}"
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now unless self.guest?
  end
end
