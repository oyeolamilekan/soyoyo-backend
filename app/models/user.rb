class User < ApplicationRecord
    has_many :business
    has_secure_password

    validates_presence_of :email, :password, :first_name, :last_name
    validates_uniqueness_of :email, message: "This user with email already exists"

    def as_json(options = {})
        super(options.merge({ except: [:id, :password, :password_digest], methods: [:token] }))
    end

    def token
        EncodeJsonWebToken.call({user_id: self.id})
    end
end