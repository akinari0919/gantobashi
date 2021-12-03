Rails.application.routes.draw do
  root 'home#top'
  get 'test', to: 'test#result'
end
