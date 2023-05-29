class CreateProviderService < ApplicationService
    attr_reader :provider_params

    def initialize(provider_params)
        @provider_params = provider_params
    end

    def call
        Provider.create!(@provider_params)
    end
end