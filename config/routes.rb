Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Posts
  resources :posts, module: :content, only: %w[index show]

  # Pages - with nested subcategories
  resources :pages, module: :content, only: %w[show], path: ""

  # Spanish home page
  get "hogar", to: "content/pages#show", id: "hogar"

  # Main section pages
  get "business", to: "content/pages#show", id: "business"
  get "negocios", to: "content/pages#show", id: "negocios"
  get "personal", to: "content/pages#show", id: "personal"
  get "seccion-personal", to: "content/pages#show", id: "seccion-personal"

  # Subcategory pages
  get "business/software", to: "content/pages#show", id: "business/software"
  get "business/management", to: "content/pages#show", id: "business/management"
  get "business/leadership", to: "content/pages#show", id: "business/leadership"
  get "personal/books", to: "content/pages#show", id: "personal/books"
  get "personal/society", to: "content/pages#show", id: "personal/society"
  get "personal/recreation", to: "content/pages#show", id: "personal/recreation"
  get "personal/learning", to: "content/pages#show", id: "personal/learning"

  # Privacy page
  get "privacy", to: "content/pages#show", id: "privacy"

  # RSS Feed
  get "feed.xml", to: "content/pages#show", id: "feed.xml", defaults: { format: :xml }

  # Root
  root to: "content/pages#root"
end
