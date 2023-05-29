class UpdatePaymentPageService < ApplicationService
    attr_reader :payment_page, :params
    
    def initialize(payment_page, params)
        @payment_page = payment_page
        @params = params
    end

    def call
        @payment_page.update(@params)
        @payment_page
    end
end