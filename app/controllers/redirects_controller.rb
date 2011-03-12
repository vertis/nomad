class RedirectsController < ApplicationController
  def index
    if @domain = Domain.where(:name => request.headers['HTTP_HOST']).first
      if redirect = @domain.redirects.where(:old_path => "/#{params['path']}").first
        redirect_to redirect.target, :status => 301
        return
      elsif @domain.catch_all
        log_request(:status => 301, :target => @domain.catch_all)
        redirect_to @domain.catch_all, :status => 301
        return
      end
    end
    log_request(:server_name => headers['SERVER_NAME'])
    render :text => 'Not Found', :status => 404
  end

  def log_request(args={})
    headers = request.headers
    entry = {  :status => 404,
               :timestamp => Time.now,
               :request_path => headers['REQUEST_PATH'],
               :remote_addr => headers['HTTP_X_REAL_IP']
               }
    entry.merge(args)
    log = RequestLog.create(entry)
    @domain.requests << log if @domain
  end
end
