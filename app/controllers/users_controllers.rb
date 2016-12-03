class UsersController < ApplicationController

	get "/users/:slug" do
    	@user = User.find_by_slug(params[:slug])
    	erb :'tweets/user_tweets'
  	end

	get '/signup' do
    	if !!session[:user_id]
    		redirect '/tweets'
    	else
    		erb :'/users/create_user'
    	end
  	end

  	post '/signup' do
  		if params[:username] == "" || params[:email] == "" || params[:password] == ""
      		redirect to '/signup'
    	else
      		@user = User.create(params)
      		session[:user_id] = @user.id
      		redirect to '/tweets'
    	end
  	end

  	get '/login' do
    	if logged_in?
      		redirect '/tweets'
    	else
      		erb :'/users/login'
    	end
  	end

  	post '/login' do
    	@user = User.find_by(username: params[:username])
    	if @user && @user.authenticate(params[:password])
      		session[:id] = @user.id
      		redirect to "/tweets"
    	else
      		redirect to "/login"
    	end
  	end

  	get '/users/:slug' do
    	@user = current_user
    	erb :'/tweets/show_tweet'
  	end

 	get "/logout" do
    	session.clear
    	redirect "/login"
  	end

end