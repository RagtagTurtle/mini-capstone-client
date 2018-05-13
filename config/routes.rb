Rails.application.routes.draw do
  namespace :client do
    get '/products' => 'products#index'
  end
end
