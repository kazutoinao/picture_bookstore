Rails.application.routes.draw do
  root to: "public/homes#top"
  devise_for :admins, path: "admin",controllers: {
    sessions:      "admin/sessions",
    passwords:     "admin/passwords",
    registrations: "admin/registrations"
  }
  scope module: :public do
    resource :customers, only: [:show, :edit, :update] do
      collection do
        get "unsubscribe"
        patch "withdraw"
      end
    end
  end
  devise_for :customers, controllers: {
    sessions:      "public/sessions",
    passwords:     "public/passwords",
    registrations: "public/registrations"
  }

  namespace :admin do
    get "homes/top" => "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  scope module: :public do
    get "homes/top" => "homes#top"
    get "homes/about" => "homes#about"
    resources :items, only: [:index, :show] do
      collection do
        get "category_search"
        get "search"
      end
      resources :reviews, only: [:new, :show, :create, :edit, :update, :destroy]
    end
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete "destroy_all"
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post "confirm"
        get "complete"
      end
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  end
end