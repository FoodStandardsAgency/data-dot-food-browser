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

  unless Rails.env.production?
    # This route redirects the `/catalog` we need to inject into the hero image bg pattern
    # in order to make the image resolve in production
    get '/catalog/themes/:path1/:path2/:path3/:path4/:path5/:path6(.:format)',
        to: redirect('/themes/%{path1}/%{path2}/%{path3}/%{path4}/%{path5}/%{path6}.%{format}',
                     status: 302)
  end

  get '*unmatched_route', to: 'exception#render_404'
end
