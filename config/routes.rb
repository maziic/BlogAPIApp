Rails.application.routes.draw do
  # User registration and login
  post '/register', to: 'users#create'
  post '/login', to: 'sessions#create'

  # Posts
  get '/posts', to: 'posts#index'
  get '/posts/:id', to: 'posts#show'
  post '/create-post', to: 'posts#create'
  patch '/edit-post/:id', to: 'posts#update'
  delete '/delete-post/:id', to: 'posts#destroy'

  # Comments
  post '/add-comment/:post_id', to: 'comments#create'
  patch '/edit-comment/:id', to: 'comments#update'
  delete '/delete-comment/:id', to: 'comments#destroy'
end
