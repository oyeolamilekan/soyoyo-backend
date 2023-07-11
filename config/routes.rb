Rails.application.routes.draw do
  scope '/api/v1' do
    scope '/auth' do
      post '/sign_up', to: 'user#sign_up'
      post '/login', to: 'user#login'
      put '/change_password', to: 'user#change_password'
      post '/request_reset_password', to: 'user#request_reset_password'
      post '/reset_password', to: 'user#reset_password'
    end

    scope '/business' do
      post '/create_business', to: 'business#create_business'
      get '/all_businesses', to: 'business#get_all_business'
      get '/api_keys/:slug', to: 'business#api_keys'
      post '/generate_api_key/:business_slug', to: 'business#generate_api_keys'
      patch '/edit_business/:slug', to: 'business#edit_business'
    end

    scope '/provider' do
      get '/all_providers', to: 'providers#all_providers'
      post '/add_provider/:slug', to: 'providers#add_provider'
      put '/edit_provider/:slug', to: 'providers#edit_provider'
      delete '/:provider_id/remove_provider/:business_slug', to: 'providers#remove_provider'
      get '/linked_providers/:business_slug', to: 'providers#fetch_providers'
    end

    scope '/payment_page' do
      get '/fetch_payment_page_summary/:business_slug', to: 'payment_page#fetch_payment_page_summary'
      post '/create_payment_page', to: 'payment_page#create_payment_page'
      patch '/:business_slug/update_payment_page/:page_slug', to: 'payment_page#update_payment_page'
      delete '/:business_slug/delete_payment_page/:page_slug', to: 'payment_page#delete_payment_page'
      get '/fetch_payment_pages/:business_slug', to: 'payment_page#fetch_payment_pages'
      get '/fetch_payment_page/:payment_page_slug', to: 'payment_page#fetch_payment_page'
      get '/fetch_public_providers/:business_slug', to: 'payment_page#fetch_providers'
    end
  end
end
