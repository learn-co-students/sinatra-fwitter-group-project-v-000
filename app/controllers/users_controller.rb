class UsersController < ApplicationController

  get '/users/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	erb :'users/show'
  end


# SIGNUP FORM: send
  get '/users/signup' do
  	if !logged_in?
    	erb :'users/signup'
    	# , locals: {message: "Please sign up before you sign in"}
	else
		redirect to '/tweets'
	end 
  end

# SIGNUP FORM: get data and CREATE user
  post '/users/signup' do

 	if params[:username] ==  "" || params[:email] ==  "" || params[:password] == ""
      redirect to '/signup'

    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
   	  @user.save	
      session[:user_id] = @user.id
      redirect to '/tweets/'
    end
  end


#LOGIN form SEND
  get '/login' do
  	if !logged_in?
    	erb :'/users/login'
	else
		redirect to '/tweets/'
	end
  end

#LOGIN FORM: PULL IN data
  post '/login' do
	 @user = User.find_by(:username => params[:username])
	      # , password: params["password"])-- no, bec password_diest

	    if @user && @user.authenticate(params[:password])
	    	session[:user_id] = @user.id
	      	redirect to "/tweets" # or users/index
	    else
	      redirect to '/signup' # or message about trying again.error page?
   		end
	end 
 

#LOGOUT SEND FORM? Or just execute from href. 
  get '/logout' do
  	if  logged_in?
  		session.destroy #or session.clear? 
  		redirect '/login'
  	else 
  		redirect to '/index'
  	end 
  end

end
