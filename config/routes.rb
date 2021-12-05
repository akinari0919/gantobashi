Rails.application.routes.draw do
  root 'home#top'
  post 'test', to: 'test#result'
end
