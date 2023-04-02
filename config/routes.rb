Rails.application.routes.draw do

  root to: "homes#top" #root to: "homes/top"を"homes#top"にしないとエラー出るよ→Missing :controller key on routes definition, please check your routes. (ArgumentError)
  get "/home/about" => "homes#about" #topページからaboutで飛ぶとこ
  devise_for :users
  resources :books, only:[:new,:create,:index,:show,:destroy,:edit,:update]
  resources :users, only:[:new,:create,:index,:show,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
