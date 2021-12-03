Rails.application.routes.draw do
  devise_for :users
  root 'tasks#today'
  get '/tasks', to: 'tasks#all'

  resources :categories do
      resources :tasks
  end
end
