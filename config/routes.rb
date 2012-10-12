ToDoList::Application.routes.draw do
  root :to => 'welcome#index'

  resources :tasks

  devise_for :users
  
  match 'tasks/sort' => 'tasks#sort', :via => [:get, :post]

end
