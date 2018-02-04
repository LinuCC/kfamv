Rails.application.routes.draw do

  root to: 'kf/home#show'

  scope path: 'admin' do
    authenticate :user, lambda { |u| u.admin? } do
      mount RailsEmailPreview::Engine, at: 'emails'
    end
  end

  devise_for :users, class_name: 'Kf::User'

  scope module: :kf do
    resources :users, only: [:show]
    # Dirty hack to override threddeds default behaviour when creating topics
    # without class_eval'ing their controller: We just provide another route
    # to create amv topics.
    resources :amv_topics, only: [:new, :create]
  end

  mount Thredded::Engine => '/kf'
end
