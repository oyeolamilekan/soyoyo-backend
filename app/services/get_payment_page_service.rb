class GetPaymentPageService < ApplicationService
    attr_reader :params
    
    def initialize(params)
        @params = params
    end

    def call
        payment_page = PaymentPage.find_by(@params)
        raise StandardError, 'Page not found.' unless payment_page.present?
        payment_page
    end
end