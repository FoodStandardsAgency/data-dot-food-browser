Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/help', to: 'help#index'
  mount CairnCatalogBrowser::Engine => '/'

  root to: 'cairn_catalog_browser/datasets#index'

  get '/feedback', to: 'feedback#show'
  post '/feedback', to: 'feedback#create'

  get '/live-check', to: 'live_check#show'

  get '*unmatched_route', to: 'exception#render_404'
end
