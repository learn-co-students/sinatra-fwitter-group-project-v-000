class SessionsController < ApplicationController

	get '/login' do
	  if session[:user_id] == nil
	  	erb :'/sessions/login'
	  else
	  	redirect to '/tweets'
	  end
	end

	post '/login' do
	  @user = User.find_by(:username => params[:username])
	  
	  if !!@user
	  	if @user.authenticate(params[:password])
			session[:user_id] = @user.id
		
			redirect to '/tweets'
		end
		redirect to '/signup'		
	  else

	    redirect to '/signup'
	  end
	end

	get '/logout' do
	  session.clear

	  redirect to '/login'
	end

end