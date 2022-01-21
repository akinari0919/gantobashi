Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'
  get 'info', to: 'home#info'
  get 'service', to: 'home#service'
  get 'privacy', to: 'home#privacy'

  namespace :mode do
    get 'select', to: 'select#index'
    get 'check', to: 'check#new'
    get 'check/show', to: 'check#show'
    post 'check/show', to: 'check#show'
    get 'training', to: 'training#new'
  end
  post 'response/check', to: 'response#check'
  post 'response/training', to: 'response#training'

  # 例外
  get '*path', controller: 'application', action: 'render_404'
end
