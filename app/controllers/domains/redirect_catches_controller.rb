class Domains::RedirectCatchesController < ApplicationController
  def ignore
    @domain = current_user.domains.by_name(params[:domain_id])
    @redirect_catch = @domain.catches.find(params[:id])

    respond_to do |format|
      if @redirect_catch.update_attributes({:ignore => true})
        format.html { redirect_to(domain_url(@domain.name) + "#analytics", :notice => 'Path was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
