Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount TeladocCMS::Engine => "/teladoc_cms"
  root "pages#index"
  post "pages/fetch"
end
