class PaymentPageController < ApplicationController
    before_action :authorize_request_or_authorize_request_using_api_key, except: [ :fetch_payment_page, :fetch_providers ]

    def create_payment_page
        business_obj = GetBusinessService.call({slug: params[:slug]}) if params[:slug].present?
        payment_page_obj = CreatePaymentPageService.call(payment_page_params.merge(business_id: (@business_id or business_obj.id)))
        if payment_page_obj.valid?
            api_response(status: true, message: "Pages successfully created.", data: payment_page_obj, status_code: :created)
        else
            api_response(status: false, message: payment_page_obj.errors.objects.first.full_message, data: nil, status_code: :unprocessable_entity)
        end
    end

    def fetch_payment_page_summary
        enabled_payment_page_obj = GetEnabledPaymentPagesService.call(params[:business_slug]).count
        disabled_payment_page_obj = GetDisabledPaymentPagesService.call(params[:business_slug]).count
        data_count = {
            enabled: enabled_payment_page_obj,
            disabled: disabled_payment_page_obj
        }
        api_response(status: true, message: "Feath Page successfully", data: data_count, status_code: :ok)
    end

    def update_payment_page
        payment_page_obj = EditPaymentPageService.call(params[:page_slug], params[:business_slug], payment_page_params)
        api_response(status: true, message: "Page successfully edited", data: payment_page_obj, status_code: :ok)
    end

    def delete_payment_page
        payment_page_obj = DeletePaymentPageService.call(params[:page_slug], params[:business_slug])
        api_response(status: true, message: "Successfully deleted page", data: nil, status_code: :bad_request)
    end

    def fetch_payment_page
        payment_page_obj = GetPaymentPageService.call({slug: params[:payment_page_slug]})
        api_response(status: true, message: "Pages successfully fetched.", data: payment_page_obj.as_json(include: {business: {only: [:title, :slug]}}), status_code: :ok)
    end

    def fetch_payment_pages
        payment_pages_obj = GetPaymentPagesService.call(params[:business_slug])
        api_response(status: true, message: "Payment pages fetched.", data: payment_pages_obj, status_code: :ok)
    end

    def fetch_providers
        providers_obj = GetProvidersService.call(params[:business_slug])
        api_response(status: true, message: "Providers fetched", data: providers_obj, status_code: :ok)
    end

    private
    def payment_page_params
        params.permit(:title, :amount)
    end
end