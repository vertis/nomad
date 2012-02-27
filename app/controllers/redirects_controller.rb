class RedirectsController < ApplicationController
  before_filter :track
  
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
    
    def track
      headers = request.headers
      query = {"h" => {}}
      query["h"]["site_id"]="4f4bf56dcb25bc56ca000097"
      query["h"]["resource"]=headers['REQUEST_URI']
      query["h"]["referrer"]=headers['HTTP_REFERRER']
      query["h"]["title"]="N/A"
      query["h"]["user_agent"]=headers['HTTP_USER_AGENT']
      query["h"]["unique_hour"]=1
      query["h"]["unique_day"]=1
      query["h"]["unique_month"]=0
      query["h"]["unique_year"]=0
      query["h"]["screenx"]=0
      query["h"]["browserx"]=0
      query["h"]["browsery"]=0
      query["timestamp"]=(Time.now.to_i*1000)
      HTTParty.get('http://secure.gaug.es/track.gif', :query => query, :headers => {'X-Forwarded-For' => '174.129.66.63', 'X-Real-IP' => '174.129.66.63', 'Remote-Addr' => '174.129.66.63'})
    end
end
