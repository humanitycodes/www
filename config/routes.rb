Rails.application.routes.draw do
  root 'lessons#index'

  match  '/auth/github/callback' => 'sessions#create', via: [:get, :post]
  delete '/signout'              => 'sessions#destroy', as: :signout
  get    '/auth/failure'         => 'sessions#failure'

  get '/lessons/search' => 'lessons#search'
  get '/lessons' => 'lessons#index'
  get '/lessons/:key/project' => 'lessons#project'
  get '/lessons/:key/:page' => 'lessons#show'
  get '/lessons/:key', to: redirect('/lessons/%{key}/1')

  get 'mentors/:username/feedback' => 'mentors#feedback'

  resources :repositories, only: [:create, :update]
  post '/repositories/:key/submit' => 'repositories#submit'

  get '/team' => 'pages#staff'
  get '/students-guide' => 'pages#students_guide'

  resources :users, only: [:edit, :show]
  resources :students, only: [:index]
  get 'students/projects'

  # resource :subscription, except: [:show]
  # post "/stripe-webhook-#{Rails.application.secrets[:stripe][:webhook_hash]}" => 'subscriptions#webhook'

end
