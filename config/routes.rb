Rails.application.routes.draw do
  root 'home#top'
  get 'create', to: 'home#create'
  post 'check', to: 'check#result'
end
