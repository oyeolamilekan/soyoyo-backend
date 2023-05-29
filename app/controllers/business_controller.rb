class BusinessController < ApplicationController
    before_action :authorize_request

    def create_business
        business_obj = CreateBusinessService.call(params[:title], @current_user.id)
        if business_obj.valid?
            api_response true, "Business successfully created", business_obj, :created
        else
            api_response false, business_obj.errors.objects.first.full_message, nil, :unprocessable_entity
        end
    end

    def get_all_business
        businesses_obj = GetAllBusinessService.call(@current_user)
        api_response true, "Business successfully fetched", businesses_obj, :ok
    end

    def edit_business
        business_obj = EditBusinessService.call({slug: params[:slug]}, business_params)
        api_response true, "Business successfully updated", business_obj, :ok
    end

    def api_keys
        business_obj = GetBusinessService.call({slug: params[:slug]})
        if business_obj.present?
            api_response true, "Keys successfully fetched", business_obj.api_key, :ok
        else
            api_response false, "Keys does not exit", nil, :not_found
        end
    end

    def generate_api_keys
        api_key_obj = GenerateApiKeyService.call(params[:business_slug])
        if api_key_obj.present?
            api_response true, "Keys successfully generated", api_key_obj, :ok
        else
            api_response false, "Could not generate keys does not exit", nil, :not_found
        end
    end

    private
    def business_params
        params.permit(:title)
    end

end
