module ResetTokenService
    class GenerateResetTokenService < ApplicationService
        attr_reader :user

        def initialize(user)
          @user = user
        end

        def call
            ResetToken.create!(user_id: @user.id)
        end
    end
end