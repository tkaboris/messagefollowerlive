Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  require "sidekiq/web"
  #this is to open sidekiq console, in production env need to set env vars, and for other envs it will not ask auth
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"

  devise_for :listeners, :controllers => { :registrations => "registrations" }


   devise_for :speakers, :controllers => { :registrations => "speaker_registrations" }
  # devise_for :speakers
  resources :speakers, only: [:show] do
    member do
      get 'subscribe'
    end
    collection do
      get :download
    end
  end

  resources :messages do
    resources :messageparts
  end

  resources :categories, only: [:new, :create, :show]

  root 'pages#home'
  get '/about' => 'pages#about'
  get '/thomas_manton' => 'pages#thomas_manton'
  get '/thomas_watson' => 'pages#thomas_watson'
  get '/william_bates' => 'pages#william_bates'
  get '/message/delete/:id' => "delete#message"
  get '/messagepart/delete/:id' => "delete#messagepart"
  # root 'messages#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
