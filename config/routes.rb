AwsBillingRegister::Application.routes.draw do
  resources :accounts do
    resources :reports, only: [:index, :show]
  end

  root "accounts#index"
end
