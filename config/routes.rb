Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'
  get 'info', to: 'home#info'
  get 'service', to: 'home#service'
  get 'privacy', to: 'home#privacy'
  get 'select', to: 'home#select'
  get 'create', to: 'home#create'
  post 'check', to: 'check#result'
  get 'show', to: 'check#show'
end
