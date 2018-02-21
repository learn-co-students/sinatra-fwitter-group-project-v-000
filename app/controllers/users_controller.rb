class UsersController < ApplicationController

	get '/signup' do
	  if !logged_in?

		erb :'/users/new'
	  else

	  	redirect to "/tweets"
	  end
	end

	post '/signup' do
		@user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])

		if !!@user.save
		  @user.save
		  session[:user_id] = @user.id

		  redirect to "/tweets"
		else

		  redirect to "/signup"
		end
	end

	get '/users/:slug' do
	  @user = User.find_by_slug(params[:slug])

	  erb :'/users/show'
	end
	
end