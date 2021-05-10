Rails.application.routes.draw do
  resources :users
  get '/current_user', to: 'users#signed_in_user'
  scope 'user' do
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
end
