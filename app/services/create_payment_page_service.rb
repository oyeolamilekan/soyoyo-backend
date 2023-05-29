class CreatePaymentPageService < ApplicationService
  attr_reader :params
  
  def initialize(params)
    @params = params
  end

  def call
    payment_page = PaymentPage.create(@params)
    payment_page
  end
end