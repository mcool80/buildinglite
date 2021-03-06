Rails.application.routes.draw do

  root 'static#index'

  # Fee pages
  get 'fee_page/:id' => 'fee_page#index'
  post 'fee_page/add' 
  get 'fee_page/check_fee/:id' => 'fee_page#check_fee' 
  get 'fee_page/fee_report/:id' => 'fee_page#fee_report' 
  get 'fee_page/administrate/:id' => 'fee_page#administrate' 
  get 'fee_page/add_fee_transaction/:id' => 'fee_page#add_fee_transaction' 
  post 'fee_page/save_result'
  
  # Moves
  get 'moves/select_apartment' => 'moves#select_apartment'
  post 'moves/change_users' => 'moves#change_users'
  post 'moves/add_user' => 'moves#add_user'
  post 'moves/add_input' => 'moves#add_input'
  get 'moves/remove_user/:user_id/:apartment_id' => 'moves#remove_user'
  get 'moves/update_fees' => 'moves#update_fees'
  get 'moves/finish' => 'moves#finish'

  # Fees
  resources :fee_transactions

  resources :fees

  # Users
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :users
  post 'users/connect' => 'users#connect'
  

  get 'apartments/showinfo/:id' => 'apartments#showinfo'
  resources :apartments

  resources :communities

  # Assignments
  get 'assignments/latest_updates' => 'assignments#latest_updates'
  get 'assignments/show_assignments' => 'assignments#show_assignments'
  resources :assignments
  get 'assignments/close/:id' => 'assignments#close'
  get 'assignments/list/closed' => 'assignments#closed_list'

  resources :assignment_statuses

  resources :assignment_updates

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
