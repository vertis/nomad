Nomad::Application.routes.draw do
  get "terms" => "terms#index"
  get "faq" => 'faq#index'

  get "welcome/index"
  
  get "diagnostics/status" => 'diagnostics#status'

  devise_for :users

  namespace :manage do
    resources :domains, :id => %r([^/;,?]+) do
      resources :requests, :only => [:destroy]
      resources :mappings, :controller => "domains/mappings"
    end
  end

  match '*path' => 'redirects#index'

  root :to => "welcome#index", :constraints => lambda{|req| req.host =~ /nomad|127.0.0.1/ }
  root :to => "redirects#index", :constraints => lambda{|req| req.host !~ /nomad/ }

end
