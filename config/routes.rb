Rails.application.routes.draw do
  resource :profile, only: %i[edit update] do
    get :edit_recipient, on: :member
    get :edit_volunteer, on: :member
  end
  resource :need, only: %i[show new create edit update destroy]
  resources :needs, only: %i[index show]
  post 'auth', to: 'auth#create'
  get 'auth', to: 'auth#activate', as: 'activate_auth'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'main#index'
end
