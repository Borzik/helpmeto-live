Rails.application.routes.draw do
  resource :profile, only: %i[edit update]
  post 'auth', to: 'auth#create'
  get 'auth', to: 'auth#activate', as: 'activate_auth'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'main#index'
end
