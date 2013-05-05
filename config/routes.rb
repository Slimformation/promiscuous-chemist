PromiscuousChemist::Application.routes.draw do
  root :to => "home#index"
  match "categorize" => "home#categorize"
  match "simplify" => "home#simplify"
end
