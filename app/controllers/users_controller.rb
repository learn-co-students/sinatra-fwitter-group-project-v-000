class UsersController < ApplicationController

  get '/users/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	erb :'users/show'
  end


# SIGNUP FORM: send
  get '/signup' do
  	if !logged_in?
    	erb :'users/signup'
    	# , locals: {message: "Please sign up before you sign in"}
	else
		redirect to '/tweets'
	end 
  end

# SIGNUP FORM: get data and CREATE user
  post '/signup' do

 	if params[:username] ==  "" || params[:email] ==  "" || params[:password] == ""
      redirect to '/signup'

    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
   	  @user.save	
      session[:user_id] = @user.id
      redirect to "/tweets/"
    end
  end


#LOGIN form SEND
  get '/login' do
  	if !logged_in?
    	erb :'/users/login'
	  else
		 redirect to '/tweets'
	 end
  end

#LOGIN FORM: PULL IN data
  post '/login' do
	  @user = User.find_by(:username => params[:username])
	    if @user && @user.authenticate(params[:password])
	    	  session[:user_id] = @user.id
	      	redirect to "/tweets" 
	    else
	        redirect to '/' # or message about trying again.error page?
   		end
	end 
 

#LOGOUT SEND FORM? Or just execute from href. 
  get '/logout' do
  	if !logged_in? 
  		redirect to '/'
    else 
      session.destroy #or session.clear? 
      redirect '/login'
  	end 
  end

end
