class User < ActiveRecord::Base
  has_many  :apps
  before_save {self.email = email.downcase}
  validates :username, presence: true,
            length: { minimum: 3, maximum: 25},
            uniqueness: { case_senstive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.org\z/i

  validates :email, presence: true,
            uniqueness: {case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX}
end
