class Domains::MappingsController < ApplicationController
  add_crumb "Domains", '/domains'
  
  def new
    @domain = current_user.domains.by_name(params[:domain_id])
    @mapping = @domain.mappings.new
    add_crumb @domain.name, "/domains/#{params[:domain_id]}"
    add_crumb 'add a mapping'
  end

  def create
    @domain = current_user.domains.by_name(params[:domain_id])
    @mapping = @domain.mappings.new(params[:mapping])
    respond_to do |format|
      if @mapping.save
        format.html { redirect_to(domain_url(@domain.name), :notice => 'Mapping added successfully.') }
      else
        format.js { render :json => "[]" }
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @domain = current_user.domains.by_name(params[:domain_id])
    @mapping = @domain.mappings.find(params[:id])
    add_crumb @domain.name, "/domains/#{params[:domain_id]}"
    add_crumb @mapping.slug
  end

  def update
    @domain = current_user.domains.by_name(params[:domain_id])
    @mapping = @domain.mappings.find(params[:id])

    respond_to do |format|
      domain = params[:mapping]
      if @mapping.update_attributes(domain)
        format.html { redirect_to(domain_url(@domain.name) + "#mappings", :notice => 'Mapping was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.xml
  def destroy
    @domain = current_user.domains.by_name(params[:domain_id])
    @mapping = @domain.mappings.find(params[:id])
    @mapping.destroy

    respond_to do |format|
      format.html { redirect_to(domain_url(@domain.name) + "#mappings", :notice => 'Mapping was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
