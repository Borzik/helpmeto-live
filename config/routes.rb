Rails.application.routes.draw do
  resource :profile, only: %i[edit update] do
    get :edit_recipient, on: :member
    get :edit_volunteer, on: :member
  end
  resource :need, as: :my_need, only: %i[show new create edit update destroy]
  resources :needs, only: %i[index show]
  post 'auth', to: 'auth#create'
  get 'auth', to: 'auth#activate', as: 'activate_auth'
  get 'qa', to: 'main#qa', as: 'qa'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'main#index'
end
