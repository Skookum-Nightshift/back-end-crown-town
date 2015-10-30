# require "stripe"

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable

  # mount_uploader :profile_image, ImageUploader

  after_create :add_stripe_account
  
  geocoded_by :full_address
  after_validation :geocode

  belongs_to :neighborhood
  has_many :user_neighborhoods
  has_many :neighborhoods, through: :user_neighborhoods
  belongs_to :user_type
  has_many :announcements
  has_many :routes

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :clients, -> { where(role: 'client') }
  scope :employee, -> { where(role: 'employee') }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, email: true
  validates_uniqueness_of :email

  def name
    "#{first_name} #{last_name}".strip
  end

  def full_address
    "#{address_line_1}, #{city}, #{state}, #{zip}"
  end

  private

    def add_stripe_account
      # Stripe.api_key = ENV["STRIPE_SECRET"]
      #
      # stripe_user = Stripe::Customer.create(
      #   :description => "Customer for #{self.name}",
      #   :email => self.email
      # )
      #
      # self.stripe_id = stripe_user.id
      # self.save!
    end
end
