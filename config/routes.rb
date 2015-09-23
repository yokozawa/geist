Rails.application.routes.draw do

  root 'home#index'

  devise_for :members

  scope module: :member do
    get 'mypage' => 'mypage#index'

    resources :members, only: [:show] do
      get 'new_answers'
      patch 'create_answers'
    end
  end

end
