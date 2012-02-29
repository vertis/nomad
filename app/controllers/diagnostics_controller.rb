class DiagnosticsController < ApplicationController
  def status
    h = request.headers
    header_yaml = h.inject({}){|result,entry| result[entry[0]]=entry[1].inspect; result}.to_yaml
    render :text => "<pre>#{header_yaml}</pre>"
  end
end
