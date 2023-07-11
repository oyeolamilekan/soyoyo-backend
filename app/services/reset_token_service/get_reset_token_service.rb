module ResetTokenService
    class GetResetTokenService < ApplicationService
        attr_reader :params

        def initialize(params)
          @params = params
        end

        def call
            ResetToken.find_by(@params)
        end
    end
end