class RedirectsController < ApplicationController
  def index
    if @domain = Domain.where(:name => request.headers['HTTP_HOST']).first
      if redirect = @domain.redirects.where(:old_path => "/#{params['path']}").first
        redirect_to redirect.target, :status => 301
        return
      elsif @domain.catch_all
        log_request(:status => 301, :target => @domain.catch_all)
        redirect_to @domain.catch_all
        return
      end
    end
    log_request
    render :text => 'Not Found', :status => 404
  end

  def log_request(args={})
    headers = request.headers
    entry = {  :status => (args[:status]||404),
               :timestamp => Time.now,
               :request_uri => headers['REQUEST_URI'],
               :remote_addr => headers['REMOTE_ADDR']
               }
    entry.reverse_merge(args)
    log = RequestLog.create(entry)
    @domain.requests << log if @domain
  end
end
