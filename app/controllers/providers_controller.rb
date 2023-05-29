class ProvidersController < ApplicationController
  before_action :authorize_request

  def all_providers
    providers_obj = load_yaml_file("data/provider.yml")
    api_response true, "Providers fetched", providers_obj, :ok
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
      api_response true, "Successfully added provider", provider, :created
    else
      api_response true, provider.errors.objects.first.full_message, nil, :unprocessable_entity
    end
  end

  def edit_provider
    provider = EditProviderService.call(params[:provider_title], params[:slug], params[:public_key])
    api_response true, "Provider successfully updated", provider, :ok
  end

  def remove_provider
    provider_obj = DeleteProviderService.call(params[:provider_id], params[:business_slug])
    api_response true, "Successfully removed provider", nil
  end

  def fetch_providers
    providers_obj = GetProvidersService.call(params[:business_slug])
    api_response true, "Providers fetched", providers_obj.as_json(include: {business: {only: [:title, :slug]}}), :ok
  end

  private
  def add_provider_params
    params.permit(:title, :name)
  end

  def remove_provider_params
    params.permit(:id)
  end
  
end
