class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect :'/tweets/tweets'
      else
      erb :"/users/create_user"
    end
  end


  post '/signup' do
    if params[:username].length == 0 || params[:password].length == 0 || params[:email].length == 0
      redirect '/signup'
    else
      @user = User.new(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect :'/tweets/tweets'
    else
    erb :'/users/login'
  end
end

	post "/login" do
		#your code here!
		@user = User.find_by(:username => params[:username])
		if @user && @user.authenticate(params[:password])
		  session[:user_id] = @user.id
		  redirect '/tweets'
		else
		  redirect '/login'
		end
		end

		get '/logout' do
		  session.clear
		  redirect '/login'
		end

		get '/users/:slug' do
		  @user = current_user
		  @tweets = @user.tweets
		  erb :'/users/show'
		end


  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end


end
