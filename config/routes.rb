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
  end

  resources :users, only: %i[new index create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # 例外
  get '*path', controller: 'application', action: 'render_404'
end
