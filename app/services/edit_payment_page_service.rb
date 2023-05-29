class EditPaymentPageService < ApplicationService
    attr_reader :page_slug, :business_slug, :payment_page_params
    
    def initialize(page_slug, business_slug, payment_page_params)
        @page_slug = page_slug
        @business_slug = business_slug
        @payment_page_params = payment_page_params
    end

    def call
        payment = PaymentPage.joins(:business).find_by(slug: page_slug, businesses: { slug: business_slug })
        payment.update(@payment_page_params)
        payment
    end
end