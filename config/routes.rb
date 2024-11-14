Rails.application.routes.draw do
  # Route pour vérifier l'état de l'application
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes pour les listes
  resources :lists, only: [:index, :show, :new, :create] do
    # Routes imbriquées pour les signets dans une liste spécifique
    resources :bookmarks, only: [:new, :create]
  end

  # Route directe pour supprimer un signet sans l'imbriquer sous liste
  resources :bookmarks, only: [:destroy]

  # Vous pouvez définir la page d'accueil ici si nécessaire
  # root "lists#index" (par exemple)
end
