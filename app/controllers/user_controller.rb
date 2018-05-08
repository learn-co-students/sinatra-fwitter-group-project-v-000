class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/create_user"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    if logged_in?

    else

    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
    redirect '/tweets'
    else
    redirect "/signup"
    end
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
