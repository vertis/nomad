class ManageController < ApplicationController
  def request_details
    render :text => "#{request.inspect}"
  end

end
