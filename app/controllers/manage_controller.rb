class ManageController < ApplicationController
  def request_details
    render :text => request.to_yaml
  end

end
