Rails.application.routes.draw do

  root 'available_products#index'

  scope 'available-products' do
    get  '/',       to: 'available_products#index'
    get  '/list',   to: 'available_products#list'
    get  '/show',   to: 'available_products#show'
    post '/create', to: 'available_products#create'
    put  '/update', to: 'available_products#update'
  end

end
