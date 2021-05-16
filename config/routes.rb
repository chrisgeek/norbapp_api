Rails.application.routes.draw do
  resources :groups
  resources :pending_requests do
    get 'approve_request', on: :collection
    get 'deny_request', on: :collection
  end
  get '/current_user', to: 'users#signed_in_user'
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
  resources :users
end
