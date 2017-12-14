class UsersController < ApplicationController

# SIGNUP FORM: send
  get '/users/signup' do
  	if !is_logged_in? 
    	erb :'/users/signup'
	else
		redirect to '/tweets/'
	end 
  end

# SIGNUP FORM: get data and CREATE user
  post '/users/signup' do
binding.pry

 if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'	
    # if params[:username] == "" || params[:email] == "" ||  params[:password] == ""
    #   redirect to '/signup' #message add here? 
 
    # else
    #   @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    #   @user.save # or @user.save!
    #   session[user_id] = @user.id
    #   redirect to '/tweets/'
    # end
    
  end

#LOGIN form SEND
  get '/users/login' do
  	if !logged_in?
    	erb :'/login'
	else
		redirect to '/tweets/'
	end
  end

#LOGIN FORM: PULL IN data
  post '/login' do
    @user = User.find_by(username => params["username"])
      # , password: params["password"])-- no, bec password_diest

    if @user && @user.authenticate(params["password"])

      session[:user_id] = @user.id
      redirect '/tweets' # or users/index
    else
      redirect to '/login' # or message about trying again.error page?
    end
  end

#LOGOUT SEND FORM? Or just execute
  get 'logout' do
  	if logged_in?
  		session.destroy  #or session.clear? 
  		redirect to '/login'
  	else 
  		redirect to '/'
  	end 
  end

end
