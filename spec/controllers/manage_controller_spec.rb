require 'spec_helper'

describe ManageController do

  describe "GET 'request_details'" do
    it "should be successful" do
      get 'request_details'
      response.should be_success
    end
  end

end
