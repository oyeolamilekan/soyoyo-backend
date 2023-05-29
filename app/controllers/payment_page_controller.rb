class PaymentPageController < ApplicationController
    before_action :authorize_request_or_authorize_request_using_api_key, except: [ :fetch_payment_page, :fetch_providers ]

    def create_payment_page
        business_obj = GetBusinessService.call({slug: params[:slug]}) if params[:slug].present?
        payment_page_obj = CreatePaymentPageService.call(payment_page_params.merge(business_id: (@business_id or business_obj.id)))
        if payment_page_obj.valid?
            api_response true, "Pages successfully created.", payment_page_obj, :created
        else
            api_response false, payment_page_obj.errors.objects.first.full_message, nil, :unprocessable_entity
        end
    end

    def fetch_payment_page_summary
        enabled_payment_page_obj = GetEnabledPaymentPagesService.call(params[:business_slug]).count
        disabled_payment_page_obj = GetDisabledPaymentPagesService.call(params[:business_slug]).count
        data_count = {
            enabled: enabled_payment_page_obj,
            disabled: disabled_payment_page_obj
        }
        api_response true, "Feath Page successfully", data_count, :ok
    end

    def update_payment_page
        payment_page_obj = EditPaymentPageService.call(params[:page_slug], params[:business_slug], payment_page_params)
        api_response true, "Page successfully edited", payment_page_obj, :ok
    end

    def delete_payment_page
        payment_page_obj = DeletePaymentPageService.call(params[:page_slug], params[:business_slug])
        api_response true, "Successfully deleted page", nil
    end

    def fetch_payment_page
        payment_page_obj = GetPaymentPageService.call({slug: params[:payment_page_slug]})
        api_response true, "Pages successfully fetched.", payment_page_obj.as_json(include: {business: {only: [:title, :slug]}}), :ok
    end

    def fetch_payment_pages
        payment_pages_obj = GetPaymentPagesService.call(params[:business_slug])
        api_response true, "Payment pages fetched.", payment_pages_obj, :ok
    end

    def fetch_providers
        providers_obj = GetProvidersService.call(params[:business_slug])
        api_response true, "Providers fetched", providers_obj, :ok
    end

    private
    def payment_page_params
        params.permit(:title, :amount)
    end
end