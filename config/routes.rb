Rails.application.routes.draw do
  root 'pages#home'
  get 'about' , to: 'pages#about'
  resources :articles
  get 'signup', to: 'users#new'
  #login / logout 
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users, except:[:new] # post 'users' to: 'users#cretae'
  resources :categories, except:[:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
