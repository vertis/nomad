class DomainsController < ApplicationController
  before_filter :authenticate_user!
  
  add_crumb "Domains", '/domains'
  
  # GET /domains
  # GET /domains.xml
  def index
    @domains = current_user.domains.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @domains }
    end
  end

  # GET /domains/1
  # GET /domains/1.xml
  # def show
  #   @domain = current_user.domains.find(params[:id])
  #   @requests = @domain.requests.limit(30).order_by([:timestamp, :desc])
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @domain }
  #   end
  # end

  # GET /domains/new
  # GET /domains/new.xml
  def new
    add_crumb "add a domain"
    @domain = current_user.domains.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @domain }
    end
  end

  # GET /domains/1
  def show
    @domain = current_user.domains.by_name(params[:id])
    add_crumb @domain.name
    @mappings = @domain.mappings
    @catches = @domain.catches.where(:ignore.ne => true).limit(30).desc(:updated_at)
  end

  # POST /domains
  # POST /domains.xml
  def create
    domain = params[:domain]
    #domain[:alternative_names] = domain[:alternative_names].split(',').map(&:strip)
    @domain = current_user.domains.new(domain)
    respond_to do |format|
      if @domain.save
        format.html { redirect_to(domains_path, :notice => 'Domain added successfully.') }
        format.xml  { render :xml => @domain, :status => :created, :location => @domain }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @domain.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /domains/1
  # PUT /domains/1.xml
  def update
    @domain = current_user.domains.by_name(params[:id])

    respond_to do |format|
      domain = params[:domain]
      #domain[:alternative_names] = domain[:alternative_names].split(',').map(&:strip)
      if @domain.update_attributes(domain)
        format.html { redirect_to(domain_path(@domain.name), :notice => 'Domain was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @domain.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.xml
  def destroy
    @domain = current_user.domains.by_name(params[:id])
    @domain.destroy

    respond_to do |format|
      format.html { redirect_to(domains_url) }
      format.xml  { head :ok }
    end
  end
end
