Nomad::Application.routes.draw do
  get "terms" => "terms#index"
  get "faq" => 'faq#index'

  get "welcome/index"
  
  get "diagnostics/status" => 'diagnostics#status'

  devise_for :users

  resources :domains, :id => %r([^/;,?]+) do
    resources :redirect_catches, :only => [], :controller => "domains/redirect_catches" do
      put "ignore", :on => :member
    end
    resources :mappings, :controller => "domains/mappings"
  end
  #put "domains/:domain_id/redirect_catches/:id/ignore", :controller => "domains/redirect_catches", :action => :ignore, :as => 'ignore_domain_redirect_catch'

  match '*path' => 'redirects#index'

  root :to => "welcome#index", :constraints => lambda{|req| req.host =~ /nomad|127.0.0.1/ }
  root :to => "redirects#index", :constraints => lambda{|req| req.host !~ /nomad/ }

end
