class Manage::Domains::MappingsController < ApplicationController
  def create
    @domain = current_user.domains.find(params[:domain_id])
    @mapping = @domain.mappings.new(params[:mapping])
    Rails.logger.debug(@domain.inspect)
    respond_to do |format|
      if false #@mapping.save
        format.html { redirect_to(manage_domain_url(@domain), :notice => 'Mapping added successfully.') }
      else
        format.js { render :json => "[]" }
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @domain = current_user.domains.find(params[:domain_id])
    @mapping = @domain.mappings.find(params[:id])

    respond_to do |format|
      domain = params[:mapping]
      if @mapping.update_attributes(domain)
        format.html { redirect_to(manage_domain_url(@domain) + "#mappings", :notice => 'Mapping was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /manage/domains/1
  # DELETE /manage/domains/1.xml
  def destroy
    @domain = current_user.domains.find(params[:domain_id])
    @mapping = @domain.mappings.find(params[:id])
    @mapping.destroy

    respond_to do |format|
      format.html { redirect_to(manage_domain_url(@domain) + "#mappings", :notice => 'Mapping was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
