Rails.application.routes.draw do

  resources :intcalcitems
  resources :inttableitems
  resources :intitems do
    collection { post :import }
  end
  resources :inttypes do
    collection { post :import }
  end
  resources :stages
  resources :notes
  resources :comments
  resources :images
 

   devise_for :users, controllers: { registrations: "registrations" }

  resources :blogs do
    resources :comments
  end
  get 'blogs/index'


   root to: 'static#index'
   get 'static/index'
   get 'static/services'
   get 'static/about'
   get 'static/contact'
   get 'static/portfolio_1'
   get 'static/portfolio_item'
   get 'static/blog_home_2'
   get 'static/blog_post'
   get 'static/full_width'
   get 'static/sidebar'
   get 'static/faq'
   get 'static/error'
   get 'static/pricing'
 

  resources :subscribers
  
  resources :merchants do
    collection { post :import }  
  end

  resources :descriptions do
    collection do
      match 'choose', via: :get
    end
    collection { post :import }
  end

  resources :descriptions do
    resources :prospects
  end
  
  resources :costs do
    collection { post :import }
  end

  resources :processors do
    resources :programs do
      collection { post :import }
    end

  end
  
    resources :prospects do
      resources :statements do 
        resources :comparisons
      end  
      resources :notes
    end

  namespace :admin do
    resources :users
    resources :costs
    resources :descriptions
    resources :merchants
    resources :processors
    resources :programs
    resources :prospects
    resources :statements

    root to: "users#index"
  end
  
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
