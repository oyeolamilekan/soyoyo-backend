class ProvidersController < ApplicationController
  before_action :authorize_request

  def all_providers
    providers_obj = load_yaml_file("data/provider.yml")
    api_response(status: true, message: "Providers fetched", data: providers_obj, status_code: :ok)
  end

  def add_provider
    providers_obj = load_yaml_file("data/provider.yml")
    business_obj = GetBusinessService.call({slug: params[:slug]})
    provider_obj = providers_obj.find { |provider| provider[:title] == params[:provider_title] }
    data = { 
      name: provider_obj[:name], 
      title: provider_obj[:title], 
      public_key: params[:public_key] 
    }
    provider = CreateProviderService.call(data.merge(business_id: business_obj.id))
    if provider.valid?
      api_response(status: true, message: "Successfully added provider", data: provider, status_code: :created)
    else
      api_response(status: true, message: provider.errors.objects.first.full_message, data: nil, status_code: :unprocessable_entity)
    end
  end

  def edit_provider
    provider = EditProviderService.call(params[:provider_title], params[:slug], params[:public_key])
    api_response(status: true, message: "Provider successfully updated", data: provider, status_code: :ok)
  end

  def remove_provider
    provider_obj = DeleteProviderService.call(params[:business_slug], params[:provider_id])
    api_response(status: true, message: "Successfully removed provider", data: nil)
  end

  def fetch_providers
    providers_obj = GetProvidersService.call(params[:business_slug])
    api_response(status: true, message: "Providers fetched", data: providers_obj.as_json(include: {business: {only: [:title, :slug]}}), status_code: :ok)
  end

  private
  def add_provider_params
    params.permit(:title, :name)
  end

  def remove_provider_params
    params.permit(:id)
  end
  
end
