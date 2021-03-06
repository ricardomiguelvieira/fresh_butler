class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :butler_bookings, class_name: :Booking, foreign_key: "butler_id", dependent: :destroy
  has_many :client_bookings, class_name: :Booking, foreign_key: "client_id", dependent: :destroy
  has_many :butler_reviews, class_name: :Review, foreign_key: "butler_id"
  # validates :first_name, presence: tru
  # validates :last_name, presence: true
  # validates :address, presence: true
  # validates :phone_number, presence: true
  # validates :butler, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def full_name
    first_name + " " + last_name
  end
end
