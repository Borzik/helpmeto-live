Rails.application.routes.draw do
  resources :offers
  resource :profile, only: %i[edit update] do
    get :edit_recipient, on: :member
    get :edit_volunteer, on: :member
  end
  resource :need, as: :my_need, only: %i[show edit update destroy]
  resources :needs, only: %i[index show] do
    resources :offers, only: %i[index create]
  end
  post 'auth', to: 'auth#create'
  get 'auth', to: 'auth#activate', as: 'activate_auth'
  get 'qa', to: 'main#qa', as: 'qa'
  get 'tos', to: 'main#tos', as: 'tos'
  get 'privacy_policy', to: 'main#privacy_policy', as: 'privacy_policy'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'main#index'
end
