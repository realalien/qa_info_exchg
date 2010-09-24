class ReleasePackagesController < ApplicationController
  # GET /release_packages
  # GET /release_packages.xml
  def index    
    @release_packages = ReleasePackage.all
    @today_release_packages = @release_packages.select(&:todays?)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @release_packages }
    end
  end

  # GET /release_packages/1
  # GET /release_packages/1.xml
  def show
    @release_package = ReleasePackage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @release_package }
    end
  end

  # GET /release_packages/new
  # GET /release_packages/new.xml
  def new
    @release_package = ReleasePackage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @release_package }
    end
  end

  # GET /release_packages/1/edit
  def edit
    @release_package = ReleasePackage.find(params[:id])
  end

  # POST /release_packages
  # POST /release_packages.xml
  def create
    @release_package = ReleasePackage.new(params[:release_package])

    respond_to do |format|
      if @release_package.save
        format.html { redirect_to(@release_package, :notice => 'Release package was successfully created.') }
        format.xml  { render :xml => @release_package, :status => :created, :location => @release_package }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @release_package.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /release_packages/1
  # PUT /release_packages/1.xml
  def update
    @release_package = ReleasePackage.find(params[:id])

    respond_to do |format|
      if @release_package.update_attributes(params[:release_package])
        format.html { redirect_to(@release_package, :notice => 'Release package was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @release_package.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /release_packages/1
  # DELETE /release_packages/1.xml
  def destroy
    @release_package = ReleasePackage.find(params[:id])
    @release_package.destroy

    respond_to do |format|
      format.html { redirect_to(release_packages_url) }
      format.xml  { head :ok }
    end
  end
  
  def send_qa_notification
    @todays = @release_packages.select(&:todays?)
    NotifyQaAboutRelease.send_release_notification(@todays)
  end
  
  def search
    
  end
  
end
