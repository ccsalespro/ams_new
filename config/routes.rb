Rails.application.routes.draw do

  root to: 'static#index'
  devise_for :users, controllers: { registrations: "registrations" }
  resources :custom_field_types
  resources :courseusers
  resources :systems
  resources :structures
  resources :internal_contacts
  resources :processorusers
  resources :stages
  resources :notes
  resources :comments
  resources :images
  resource :subscription
  resource :card

  resources :lessonusers do
    member do
      patch :complete
    end
  end

  resources :courses do
    resources :chapters do
      resources :lessons do
        member do
          patch :complete
        end
      end
    end
  end

  resources :intcalcitems do
    collection { post :import }
  end

  resources :inttableitems
  resources :intitems do
    collection { post :import }
  end
  resources :inttypes do
    collection { post :import }
  end

  resources :blogs do
    resources :comments
  end

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

  resources :processors do
    resources :programs do
      member do
        get 'clone'
      end
    end
  end

  resources :programusers do
    member do
      get 'toggle_edit_permission'
    end
  end

  resources :programs do
    resources :custom_fields
  end

    resources :prospects do
      resources :statements do
        resources :comparisons
      end
      resources :notes
      resources :tasks
    end

    resources :users do
      resources :tickets
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
  
  get 'lessonusers/link_complete'
  get 'blogs/index'
  get 'tasks/index'
  get 'comparisons/show'
  get 'comparisons/decrease_savings'
  get 'comparisons/increase_savings'
  get 'statements/downgrade_edit'
  get 'statements/downgrade_update'
  get 'statements/regulated_check_card_update'
  get 'statements/unregulated_check_card_update'
  get 'statements/btob_update'
  get 'statements/moto_update'
  get 'statements/ecomm_update'
  get 'statements/interchange_update'
  get 'admin_dashboard/destroy_user'
  get 'admin_dashboard/index'
  get 'admin_dashboard/subscribe'
  get 'admin_dashboard/unsubscribe'
  get 'admin_dashboard/training_subscribe'
  get 'admin_dashboard/untraining_subscribe'
  get 'admin_dashboard/make_admin'
  get 'admin_dashboard/remove_admin'
  get 'admin_dashboard/show_user'
  get 'admin_dashboard/destroy_prospect'
  get 'admin_dashboard/destroy_programuser_admin_panel'
  get 'admin_dashboard/assign_programs'
  get 'admin_dashboard/all_tickets'
  get 'tickets/mark_important'
  get 'tickets/mark_unimportant'
  get 'tasks/mark_complete'
  get 'tasks/mark_uncomplete'
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
  get 'calendars/index'

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
