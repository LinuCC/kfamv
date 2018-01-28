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
  end
  mount Thredded::Engine => '/kf'
end
