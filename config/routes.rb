Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/help', to: 'help#index'
  mount CairnCatalogueBrowser::Engine => '/'

  root to: 'cairn_catalogue_browser/datasets#index'
end
