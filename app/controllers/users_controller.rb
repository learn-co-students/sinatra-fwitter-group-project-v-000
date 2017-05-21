class UsersController < ApplicationController

	get '/signup' do
  	if !logged_in?
  		erb :'users/create_user'
  	else
  		redirect '/tweets'
  	end
  end

  post '/signup' do
	  	if params[:username] != "" && params[:email] != "" && params[:password] != ""
	  		@user = User.create(params)
	  		session[:id] = @user.id
	  		redirect '/tweets'
	  	end
  	redirect '/signup'
  end

  get "/users/:slug" do
  	@user = User.find_by_slug(params[:slug])
  	erb :'users/tweets'
  end
  
end