class RedirectsController < ApplicationController
  include Gauges

  def index
    hostname = request.headers['HTTP_HOST'] || 'localhost'
    hostname, port = hostname.split(':')
    hostname.gsub!(/^www\./,'')
    @domain = Domain.where(:name => /#{hostname}/).first
    if @domain
      if params['path'].present? && mapping = @domain.mappings.where(:source_path => /^\/#{params['path']}/).first
        redirect_to mapping.target, :status => 301
        return
      else
        redirect_catch = @domain.catches.where(:source_path => /^\/#{params['path']}/).first 
        redirect_catch ||= @domain.catches.create(:source_path => "/#{params['path']}")
        redirect_catch.touch
        redirect_to @domain.catch_all, :status => 301
        return
      end
    end
    render :text => 'Not Found', :status => 404
  end
end
