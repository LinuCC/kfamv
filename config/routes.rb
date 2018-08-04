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

  namespace :kf do
    # Dirty hack to override threddeds default behaviour when creating topics
    # without class_eval'ing their controller: We just provide another route
    # to create amv topics.
    resources :amv_topics, only: [:new, :create, :edit]

    # If you submit the form, get an error in dev (maybe in prod too?) and reload
    # you would be greeted by another error because Thredded takes over and tries
    # to load the non-existing messageboard "amv_topics"
    get :amv_topics, to: redirect('/kf/amvs')
  end

  mount Thredded::Engine => '/kf'
end
