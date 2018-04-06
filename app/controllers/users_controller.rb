class UsersController < ApplicationController

  # User Registration ------------------------------------------------------- 

  get '/signup' do
    redirect to '/tweets' if logged_in?
    erb :'users/create_user'
  end 

  post '/signup' do 
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      @user.save 
      session[:user_id] = @user.id
      redirect to '/tweets'
    else 
      redirect to '/signup'
    end 
  end
 
  # User Login / Logout -----------------------------------------------------
  
  get '/login' do
    if !logged_in? then erb :'users/login' else redirect to '/tweets' end
  end 

  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:incorrectinfo] = "The username and password you entered did not match our records. Please double-check and try again."
      erb :'users/login'
    end
  end 

  get '/logout' do
    if logged_in? then session.clear and redirect to '/login' else redirect to '/' end
  end 

  # User Show Page  ---------------------------------------------------------

  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end 

end 