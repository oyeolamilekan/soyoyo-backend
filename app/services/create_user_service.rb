class CreateUserService < ApplicationService
    attr_reader :email, :password, :first_name, :last_name

    def initialize(email, password, first_name, last_name)
        @email = email
        @password = password
        @first_name = first_name
        @last_name = last_name
    end

    def call
        user_exist = GetUserService.call(email)
        raise StandardError, "User already exists" if user_exist.present?
        user_obj = User.create!(email: @email, password: @password, first_name: @first_name, last_name: @last_name)
        return user_obj
    end
end
