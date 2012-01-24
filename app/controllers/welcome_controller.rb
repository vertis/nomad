class WelcomeController < ApplicationController
  before_filter :redirect_to_manage_domains_if_logged_in

  def index
  end

  private
    def redirect_to_manage_domains_if_logged_in
      redirect_to(manage_domains_path) if user_signed_in?
      #false
    end
end
