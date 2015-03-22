Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'application#index'
  get 'about' => 'application#about', as: 'about'
  get 'contact' => 'application#contact', as: 'contact'
  get 'sales' => 'application#sales', as: 'sales'

  # Customer pages to see the categories
  get 'categories' => 'categories#index', as: 'categories'
  get 'categories/:id' => 'categories#show', as: 'category'

  # Session
  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get 'log_in' => 'sessions#new', :as => 'log_in'
  get 'sign_up' => 'users#new', :as => 'sign_up'

  # Search
  get 'search' => 'application#search'

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'

    resources :products
    resources :users
    get 'settings/about' => 'settings#about', as: 'about'
    get 'settings/contact' => 'settings#contact', as: 'contact'
    get 'settings/title' => 'settings#title', as: 'title'
    resources :settings
    get 'categories/children/' => 'categories#children'
    get 'categories/children/:parent_id(.:format)' => 'categories#children'
    get 'categories/except/:id(.:format)' => 'categories#except'
    resources :categories
  end

  post 'users' => 'users#create'
  get 'profile' => 'users#profile', :as => 'profile'
  get 'profile/edit' => 'users#edit', :as => 'edit_profile'

  get 'products' => 'products#index'
  get 'products/:id' => 'products#show', :as => 'product'

  resources :sessions

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
end
