class RedirectsController < ApplicationController
  def index

    render :text => request.inspect
  end
end
