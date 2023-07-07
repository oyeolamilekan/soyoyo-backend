class BusinessController < ApplicationController
    before_action :authorize_request

    def create_business
        business_obj = CreateBusinessService.call(params[:title], @current_user.id)
        if business_obj.valid?
            api_response(status: true, message: "Business successfully created", data: business_obj, status: :created)
        else
            api_response(status: false, message: business_obj.errors.objects.first.full_message, data: nil, status: :unprocessable_entity)
        end
    end

    def get_all_business
        businesses_obj = GetAllBusinessService.call(@current_user)
        api_response(status: true, message: "Business successfully fetched", data: businesses_obj, status: :ok)
    end

    def edit_business
        business_obj = EditBusinessService.call({slug: params[:slug]}, business_params)
        api_response(status: true, message: "Business successfully updated", data: business_obj, status: :ok)
    end

    def api_keys
        business_obj = GetBusinessService.call({slug: params[:slug]})
        if business_obj.present?
            api_response(status: true, message: "Keys successfully fetched", data: business_obj.api_key, status: :ok)
        else
            api_response(status: false, message: "Keys does not exit", data: nil, status: :not_found)
        end
    end

    def generate_api_keys
        api_key_obj = GenerateApiKeyService.call(params[:business_slug])
        if api_key_obj.present?
            api_response(status: true, message: "Keys successfully generated", data: api_key_obj, status: :ok)
        else
            api_response(status: false, message: "Could not generate keys does not exit", data: nil, status: :not_found)
        end
    end

    private
    def business_params
        params.permit(:title)
    end

end
