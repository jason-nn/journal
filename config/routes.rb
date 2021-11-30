Rails.application.routes.draw do
    root 'tasks#today'
    get '/tasks', to: 'tasks#all'

    resources :categories do
        resources :tasks
    end
end
