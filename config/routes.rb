Rails.application.routes.draw do
  resources :groups
  resources :pending_requests do
    get 'approve_request', on: :collection
    get 'deny_request', on: :collection
  end
  scope 'users' do
    devise_for :users,
               defaults: { format: :json },
               path: '',
               class_name: 'User',
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
               },
               controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations',
                 passwords: 'passwords'
               }
  end

  resources :users, except: %w[create update destroy edit new] do
    collection do
      get 'signed_in_user', format: :json
    end
  end
  resources :subscriptions do
    collection do
      get 'confirm_payment', format: :json
      get 'make_payment'
    end
  end
  resources :subscription_lists
end
