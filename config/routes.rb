Rails.application.routes.draw do

  devise_for :users

  root "pages#home"
  resources :projects
  #  Add route to select a project
  post 'select_project', to: 'projects#select_project', as: 'select_project'


  resources :tasks do
    post 'comments', to: 'comments#create'
    resources :comments, only: [:edit, :update, :destroy]

  end
  
  


end
