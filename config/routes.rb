Rails.application.routes.draw do
  root to: 'zillow#demographics'

  get 'zillow/neighborhood'

  get 'zillow/demographics'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
