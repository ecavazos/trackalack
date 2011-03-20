class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    if range = parse_date_range
      @time_entries = @user.time_entries.date_range(range[0], range[1])
    else
      days = params[:days] || 5
      @time_entries = @user.time_entries.limit_days(days.to_i)
    end

    @time_entries = @time_entries.includes(:user, :project => :client)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to(@user, :notice => 'User was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  private

  def parse_date_range
    sdate = params[:start_date]
    edate = params[:end_date]
    return false if (sdate.nil? || sdate.blank?) && (edate.nil? || edate.blank?)
    begin
      fmt = '%m/%d/%Y'
      sdate = Date.strptime(sdate, fmt)
      edate = Date.strptime(edate, fmt) unless edate.empty?
      [sdate, edate]
    rescue ArgumentError => e
      flash.now[:error] = 'Date range was invalid'
      false
    end
  end
end
