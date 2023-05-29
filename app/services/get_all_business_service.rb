class GetAllBusinessService < ApplicationService
    attr_reader :user

    def initialize(user)
        @user = user
    end

    def call
        user.business.all
    end
end