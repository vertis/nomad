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
      require 'httparty'
      headers = request.headers
      query = {"h" => {}}
      query["h"]["site_id"]="4f4bf56dcb25bc56ca000097"
      query["h"]["resource"]=headers['REQUEST_URI']
      query["h"]["referrer"]=headers['HTTP_REFERRER']
      query["h"]["title"]="301 Redirect"
      query["h"]["user_agent"]=headers['HTTP_USER_AGENT']
      query["h"]["unique"]=unique
      query["h"]["unique_hour"]=unique_hour
      query["h"]["unique_day"]=unique_day
      query["h"]["unique_month"]=unique_month
      query["h"]["unique_year"]=unique_year
      query["h"]["screenx"]=0
      query["h"]["browserx"]=0
      query["h"]["browsery"]=0
      query["timestamp"]=(Time.now.to_i*1000)

      ip = headers['X_FORWARDED_FOR'] || headers['REMOTE_ADDR']
      Rails.logger.debug("IP: #{ip}")
      Rails.logger.debug("Query: #{query}")
      HTTParty.get('http://secure.gaug.es/track.gif', :query => query, :headers => {'X-Forwarded-For' => ip, 'X-Real-IP' => ip, 'Remote-Addr' => ip})

      set_cookies
    end

    def set_cookies
      cookies[:_gauges_cookie] = { :value => 1, :expires => 1.day.from_now }
      cookies[:_gauges_unique_hour] = { :value => 1, :expires => 1.hour.from_now } unless cookies[:_gauges_unique_hour]
      cookies[:_gauges_unique_day] = { :value => 1, :expires => 1.day.from_now } unless cookies[:_gauges_unique_day]
      cookies[:_gauges_unique_month] = { :value => 1, :expires => 1.month.from_now } unless cookies[:_gauges_unique_month]
      cookies[:_gauges_unique_year] = { :value => 1, :expires => 1.year.from_now } unless cookies[:_gauges_unique_year]
      cookies[:_gauges_unique] = { :value => 1, :expires => 10.years.from_now } unless cookies[:_gauges_unique]
    end

    def unique
      return 0 unless cookies[:_gauges_cookie]
      return cookies[:_gauges_unique] ? 0 : 1
    end

    def unique_hour
      return 0 unless cookies[:_gauges_cookie]
      return cookies[:_gauges_unique_hour] ? 0 : 1
    end

    def unique_day
      return 0 unless cookies[:_gauges_cookie]
      return cookies[:_gauges_unique_day] ? 0 : 1
    end

    def unique_month
      return 0 unless cookies[:_gauges_cookie]
      return cookies[:_gauges_unique_month] ? 0 : 1
    end

    def unique_year
      return 0 unless cookies[:_gauges_cookie]
      return cookies[:_gauges_unique_year] ? 0 : 1
    end
end
