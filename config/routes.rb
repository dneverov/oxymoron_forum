Rails.application.routes.draw do
  groot to: 'groups#index'

  devise_for :users, controllers: {
    sessions: 'auth/sessions',
    registrations: 'auth/registrations',
  }

  post "uploads/avatar" => "uploads#avatar"

  get "search" => "search#index"

  resources :groups
  resources :themes
  resources :topics
  resources :posts
  resources :users, only: [:index, :show] do
    collection do
      get "touch"  # touch для current_user, чтобы обновить время онлайна
      get "metrics" # разнообразная статистика
    end
    member do
      put "rate" # Изменение рейтинга
      put "ban" # Забанить
      put "unban" # Разбанить
    end
  end
end
