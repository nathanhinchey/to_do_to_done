Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'questions#index'

  resources :questions do
    resources :options
  end

  resources :surveys do
    get 'take'
    post 'take', action: 'save_answers', as: 'save_answers'
    resources :survey_questions
  end
end
