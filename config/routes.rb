Rails.application.routes.draw do
    resources :categories do
        resources :tasks
    end
end
