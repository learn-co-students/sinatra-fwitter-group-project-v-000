class UsersController < ApplicationController

  get '/users/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	erb :'/users/show'
  end


# SIGNUP FORM: send
  get '/signup' do
  	if logged_in?
    	redirect to '/tweets'
      #or redirect to '/tweets' if logged_in?
    	# , locals: {message: "Please sign up before you sign in"}
	  else
      erb :'signup'
	  end 
  end

# SIGNUP FORM: get data and CREATE user
  post '/signup' do
 	  if params[:username] ==  "" || params[:email] ==  "" || params[:password] == ""
      flash[:notice] = "All fields must be filled in."
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
   	  @user.save	
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

#LOGIN form SEND
  get '/login' do
  	if !logged_in?
    	erb :'/login'
	  else
		 redirect to '/tweets'
	  end
  end

#LOGIN FORM: PULL IN data
  post '/login' do
    redirect to "/tweets" if logged_in?

	  @user = User.find_by(:username => params[:username])

	  if @user && @user.authenticate(params[:password])
	    	session[:user_id] = @user.id
	      redirect to "/tweets" 
	  else
      flash[:notice] = "Please provide a valid Username and Password."
	     redirect to '/' # or message about trying again.error page?
   	end
	end 
 

#LOGOUT SEND FORM? Or just execute from href. 
  get '/logout' do
  	if logged_in? 
        session.clear
        redirect to '/login'
    else 
       redirect to '/login'
  	end 
  end

end
