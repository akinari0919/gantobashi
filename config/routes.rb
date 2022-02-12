Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'
  get 'info', to: 'home#info'
  get 'service', to: 'home#service'
  get 'privacy', to: 'home#privacy'

  namespace :mode do
    get 'select', to: 'select#index'

    # 診断モード
    get 'check', to: 'check#new'
    get 'check/show', to: 'check#show'
    post 'check/show', to: 'check#show'
    post 'response/check', to: 'response#check'

    # 訓練モード
    get 'training', to: 'training#new'
    post 'response/training', to: 'response#training'

    # 決闘モード
    resources :battle, only: %i[index show edit update]
    post ':id/response/battle', to: 'response#battle'
  end

  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resource :profile, only: %i[show edit update]
  resources :glaring_face_photos, only: %i[new create index update destroy]
  get 'glaring_face_photos/hide', to: 'glaring_face_photos#hide'
  post 'glaring_face_photos/check', to: 'glaring_face_photos#check'


  # 例外
  get '*path', controller: 'application', action: 'render_404'
end
