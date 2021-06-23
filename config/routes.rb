# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/help', to: 'help#index'

  resources :datasets, only: %i[index show]

  root 'datasets#index'
  get '/', to: 'datasets#index'

  get '/feedback', to: 'feedback#show'
  post '/feedback', to: 'feedback#create'

  get '/live-check', to: 'live_check#show'

  get '/cookies', to: redirect(
    'https://www.food.gov.uk/about-us/data-and-policies/aboutsite/termsandconditions/privacypolicy/cookies',
    status: 302
  )

  get '*unmatched_route', to: 'exception#render404'
end
