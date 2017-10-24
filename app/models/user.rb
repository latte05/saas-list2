class User < ActiveRecord::Base
  has_many  :apps
  before_save {self.email = email.downcase}
  validates :username, presence: true,
            length: { minimum: 3, maximum: 25},
            uniqueness: { case_senstive: false }

<<<<<<< HEAD
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
=======
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
>>>>>>> user-association

  validates :email, 
            uniqueness: {case_sensitive: false },
<<<<<<< HEAD
            format: { with: VALID_EMAIL_REGEX }
=======
            format: { with: VALID_EMAIL_REGEX}

  has_secure_password

>>>>>>> user-association
end
