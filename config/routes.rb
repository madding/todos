Rails.application.routes.draw do
  root 'todos#index'

  resources :todos do
    put :change_status, on: :member
  end
end
