class User < ActiveRecord::Base
  before_validation :set_full_name
  attr_accessor :first_name, :last_name
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :full_name, presence: true
  validates :first_name, presence: true, length: { in: 3..25 }
  validates :last_name, presence: true, length: { in: 3..35 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :display_name, length: { in: 2..32 }, allow_blank: true
  validates :password, length: { minimum: 8 }

  private
    def set_full_name
      self.full_name = self.first_name + " " + self.last_name if self.first_name && self.last_name
    end
end
