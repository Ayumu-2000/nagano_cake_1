Rails.application.routes.draw do
  
  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'
  
  namespace :admin do
    root to: 'homes#top'
  end
  
  namespace :public do
    resources :customers, only: [:show, :edit]
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
