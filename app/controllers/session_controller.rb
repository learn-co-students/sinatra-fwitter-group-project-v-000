class SessionController < ApplicationController
	
	get '/login' do
		if logged_in?
			redirect '/tweets'
		else 
			erb :login
		end 
  end

  post '/login' do 
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
      redirect "/tweets"
    else
    	flash[:message] = "Please enter a valide username and password."
      redirect "/login"
    end
	end

  get '/signup' do
		if logged_in?
			redirect '/tweets'
		else 
			erb :signup
		end
  end

  post '/signup' do 
  	if params[:username] == "" || params[:email] == "" || params[:password] == ""
  		flash[:message] = "Please enter a valide username, email, and password."
  		redirect '/signup'
  	else
	  	@user = User.create(username: params[:username], email: params[:email], password: params[:password])
	
	  	session["user_id"] = @user.id

	  	redirect "/tweets"
	  end
  end

  get '/logout' do
  	if logged_in?
  		session.clear
  	end
  	flash[:message] = "You have been logged out. Log back in to view/edit tweets"
  	redirect '/login'
  end

end