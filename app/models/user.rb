class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :registerable,
  # :rememberable, :recoverable
  devise :database_authenticatable, :validatable
  has_many :bookings

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
