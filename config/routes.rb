Rails.application.routes.draw do
  root 'home#top'
  post 'check', to: 'check#result'
end
