module Gauges
  def track
    headers = request.headers
    query = {"h" => {}}
    query["h"]["site_id"]=Settings.gauges_site_id
    query["h"]["resource"]="http://#{headers['HTTP_HOST']}/#{headers['REQUEST_PATH']}"
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

    ip = headers['HTTP_X_FORWARDED_FOR'] || headers['REMOTE_ADDR']
    ip = ip.split(',')[0].strip
    HTTParty.get('http://secure.gaug.es/track.gif', :query => query, :headers => {'X-Forwarded-For' => ip, 'X-Real-IP' => ip, 'Remote-Addr' => ip})

    set_cookies
  end

  def set_cookies
    cookies[:_gauges_cookie] = 1
    cookies[:_gauges_unique_hour] = { :value => 1, :expires => 1.hour.from_now } unless cookies[:_gauges_unique_hour]
    cookies[:_gauges_unique_day] = { :value => 1, :expires => 1.day.from_now } unless cookies[:_gauges_unique_day]
    cookies[:_gauges_unique_month] = { :value => 1, :expires => 1.month.from_now } unless cookies[:_gauges_unique_month]
    cookies[:_gauges_unique_year] = { :value => 1, :expires => 1.year.from_now } unless cookies[:_gauges_unique_year]
    cookies[:_gauges_unique] = { :value => 1, :expires => 10.years.from_now } unless cookies[:_gauges_unique]
  end

  def unique
    return 0 if cookies[:_gauges_cookie].present?
    return cookies[:_gauges_unique] ? 0 : 1
  end

  def unique_hour
    return 0 if cookies[:_gauges_cookie].present?
    return cookies[:_gauges_unique_hour] ? 0 : 1
  end

  def unique_day
    return 0 if cookies[:_gauges_cookie].present?
    return cookies[:_gauges_unique_day] ? 0 : 1
  end

  def unique_month
    return 0 if cookies[:_gauges_cookie].present?
    return cookies[:_gauges_unique_month] ? 0 : 1
  end

  def unique_year
    return 0 if cookies[:_gauges_cookie].present?
    return cookies[:_gauges_unique_year] ? 0 : 1
  end
end