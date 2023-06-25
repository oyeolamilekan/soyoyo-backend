class GetUserService < ApplicationService
    attr_reader :email

    def initialize(email)
        @email = email
    end

    def call
        user = User.find_by(email: @email)
        return user
    end
end