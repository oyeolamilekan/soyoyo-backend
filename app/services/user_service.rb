class UserService
    def self.create_user(params)
        user = User.create(params)
        return user
    end

    def self.find(params)
        user = User.find_by(params)
        return user
    end

    def self.encode_user_token(user_id:)
        JsonWebToken.encode({user_id: user_id})
    end
end