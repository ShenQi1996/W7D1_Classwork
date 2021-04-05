# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  user_name       :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

    validates :password, length: { minimum: 6, allow_nil: true}

    validates :user_name, :session_token, presence: true, uniqueness: true

    validates :password_digest, presence: true

    after_initialize :ensure_session_token

    def self.find_by_credentials(user_name, password)
        # debugger
        user = User.find_by(user_name: user_name)
        if user && user.is_password?(password)
           user
        else
           nil
        end
     end

    def password=(password)
        puts "password setter"
        # debugger
        self.password_digest = BCrypt::Password.create(password)
        @password = password 
     end
  
     def password 
        puts "password getter"
        @password
     end

     def ensure_session_token
        # debugger
        self.session_token ||= SecureRandom::urlsafe_base64
     end
  
     def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
     end
  
     def reset_session_token
        self.session_token = SecureRandom::urlsafe_base64
        # debugger
        self.save!
        self.session_token
     end

end
