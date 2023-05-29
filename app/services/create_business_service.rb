class CreateBusinessService < ApplicationService
    attr_reader :user_id, :title

    def initialize(title, user_id)
        @user_id = user_id
        @title = title
    end

    def call
        business = Business.create(title: @title, user_id: @user_id)
        business
    end
end