class Manage::Domains::RequestsController < ApplicationController
  def destroy
    @domain = current_user.domains.find(params[:domain_id])
    @request = @domain.requests.find(params[:id])
    @request.destroy
    respond_to do |format|
      format.html { redirect_to(manage_domains_url) }
      format.xml  { head :ok }
    end
  end
end
