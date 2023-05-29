class GetEnabledPaymentPagesService < ApplicationService
    attr_reader :business_slug

    def initialize(business_slug)
        @business_slug = business_slug
    end

    def call
        payment_page = PaymentPage.joins(:business).where(businesses: { slug: @business_slug }).enabled
        return payment_page
    end
end