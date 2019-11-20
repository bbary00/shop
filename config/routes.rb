Rails.application.routes.draw do
  resources :items do
    get :upvote, on: :member
    get :hot, on: :collection
  end
end
