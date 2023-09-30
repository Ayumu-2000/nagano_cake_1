Rails.application.routes.draw do

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'

  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :show, :index, :edit, :create, :update]
    resources :orders, only: [:show]
  end

  scope module: :public do
    get '/orders/new' => 'orders#new'
    post '/orders/check' => 'orders#check'
    get '/orders/finish' => 'orders#finish'
    post '/orders' => 'orders#create'
    get '/orders' => 'orders#index'
    get '/orders/:id' => 'orders#show', as: :order
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    delete '/cart_items/:id' => 'cart_items#destroy', as: :cart_item
    get '/cart_items' => 'cart_items#index'
    post '/cart_items' => 'cart_items#create'
    patch '/cart_items/:id' => 'cart_items#update'
    #delete '/cart_items/:id' => 'cart_items#destroy'
    #delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    get '/customers' => 'customers#show'
    get '/customers/edit' => 'customers#edit'
    get '/customers/check' => 'customers#check'
    patch '/customers' => 'customers#update', as: 'update'
    patch '/customers/out' => 'customers#out'
    resources :items, only: [:index, :show]
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
