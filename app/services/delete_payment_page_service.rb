class DeletePaymentPageService < ApplicationService
    attr_reader :slug, :business_slug
    
    def initialize(slug, business_slug)
        @slug = slug
        @business_slug = business_slug
    end

    def call
        PaymentPage.joins(:business).find_by(slug: @slug, businesses: { slug: @business_slug }).destroy!  
    end
end