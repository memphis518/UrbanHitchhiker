class UsersController < ApplicationController
   
  before_filter :login_required, :only=>['edit', 'update']
  
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
    if(params[:id].to_i == session[:user_id])
      @user = User.find(params[:id])
    else
      render :template => 'users/loginfailed'
    end
    
  end

  # POST /users
  # POST /users.xml
  def create
    session[:user_id] = nil
    @user = User.new(params[:user])
    # TODO Find a better way to do this
    if (params[:user][:password] == "DO NOT UPDATE")
        params[:user][:password]= nil
    end
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id;
        format.html { redirect_to(edit_user_path(@user)) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    if(params[:id].to_i == session[:user_id])
      @user = User.find(params[:id])
      respond_to do |format|
        # TODO Find a better way to do this
        params[:user][:password] = "DO NOT UPDATE"
        params[:user][:password_confirm] = "DO NOT UPDATE"
        if @user.update_attributes(params[:user])
          @success = true;
          format.html { render :action => "edit" }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      render :template => 'users/loginfailed'
    end
  end
  
  # POST /users/login
  def login
    if(request.post? && params[:username] && params[:password])
        @user = User.authenticate(params[:username], params[:password])
        if(@user)
            session[:user_id] = @user.id;
            redirect_to_stored
        else
            render :template => 'users/loginfailed'
        end
    elsif(session[:user_id]) 
        redirect_to_stored
    else
        session[:user_id] = nil
        render :template => 'users/loginfailed'
    end
  end
  
  def logout
    reset_session
  end
  
end
