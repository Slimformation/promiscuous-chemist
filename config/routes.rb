PromiscuousChemist::Application.routes.draw do
  root :to => "home#index"
  match "categorize" => "home#index"
end
