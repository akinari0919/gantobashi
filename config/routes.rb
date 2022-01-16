Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'
  get 'info', to: 'home#info'
  get 'service', to: 'home#service'
  get 'privacy', to: 'home#privacy'

  get 'mode/index', to: 'mode#index'
  get 'mode/check', to: 'mode#check'
  post 'response/check', to: 'response#check'
  get 'mode/check/show', to: 'mode#check_show'
  post 'mode/check/show', to: 'mode#check_show'
  get 'mode/training', to: 'mode#training'
  post 'response/training', to: 'response#training'

  # 例外
  get '*path', controller: 'application', action: 'render_404'
end
