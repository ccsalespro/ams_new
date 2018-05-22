Rails.application.routes.draw do
  root :to => 'marketing/descriptions#quote'

  namespace :marketing do
    get '/quote' => 'descriptions#quote'
    resources :descriptions, only: [] do
      resources :prospects, only: [:edit]
    end

    resources :prospects, only: [] do
      resources :statements, only: [:new, :create] do
        resources :comparisons, only: [:index, :show, :create] do
          get 'savings_detail'
        end
      end
    end
  end

  resources :statements do
    collection { post :import }
  end
  resources :courses do
    collection { post :import }
  end

  resources :lessons do
    collection { post :import }
  end

  resources :chapters do
    collection { post :import }
  end
  resources :team_user_roles
  resources :team_types
  resources :team_users
  devise_for :users, controllers: {:registrations => 'registrations', :invitations => 'users/invitations'}
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

  resources :custom_field_types do
    collection {post :import}
  end

  resources :teams do
    resources :team_users, path: :users
    get 'show_individual_team_user'
    resources :chats
  end

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

  resources :prospects do
    collection {post :import}
  end

  resources :processors do
    resources :programs do
      collection { post :import }
      member do
        get 'set_default_program'
      end
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
        resources :comparisons do
          member do
            get 'savings_summary'
            get 'savings_detail'
          end
        end
      end
      resources :notes
      resources :tasks
    end

    resources :users do
      resources :tickets
    end

  get 'lessonusers/link_complete'
  get 'tasks/index'
  get 'comparisons/show'
  get 'comparisons/increase_margin'
  get 'comparisons/decrease_margin'
  get 'statements/downgrade_edit'
  get 'statements/downgrade_update'
  get 'statements/regulated_check_card_update'
  get 'statements/unregulated_check_card_update'
  get 'statements/btob_update'
  get 'statements/moto_update'
  get 'statements/ecomm_update'
  get 'statements/interchange_update'
  get 'statements/brand_edit'
  get 'statements/card_type_edit'
  get 'statements/method_edit'
  get 'statements/check_card_edit'
  get 'statements/increase_interchange'
  get 'statements/decrease_interchange'
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
end
