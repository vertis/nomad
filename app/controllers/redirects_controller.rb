class RedirectsController < ApplicationController
  before_filter :track

  include Gauges

  def index
    hostname = request.headers['HTTP_HOST']
    hostname, port = hostname.split(':')
    @domain = Domain.where(:name => /#{hostname}/).first
    #@domain ||= Domain.where(:alternative_names => /#{hostname}/).first
    if @domain
      if params['path'].present? && mapping = @domain.mappings.where(:source_path => /^\/#{params['path']}/).first
        redirect_to mapping.target, :status => 301
        return
      elsif @domain.catch_all
        log_request(:status => 301, :redirected_to => @domain.catch_all)
        redirect_to @domain.catch_all, :status => 301
        return
      end
    end
    log_request(:server_name => headers['SERVER_NAME'])
    render :text => 'Not Found', :status => 404
  end

  private
    def log_request(args={})
      headers = request.headers
      entry = {  :status => 404,
                 :timestamp => Time.now,
                 :request_path => headers['REQUEST_PATH'],
                 :remote_addr => headers['HTTP_X_REAL_IP']
                 }
      entry.merge!(args)
      log = RequestLog.create(entry)
      @domain.requests << log if @domain
    end
end
