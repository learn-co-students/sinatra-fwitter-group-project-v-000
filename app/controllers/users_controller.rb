class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :"/users/signup"
    else
      redirect to "/tweets"
    end
  end

  post '/signup' do
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      erb :"/users/signup"
    end
  end

  get '/login' do
    erb :"/users/login"
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

		if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
			redirect "/tweets"
		else
			erb :"/users/login"
		end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to "/"
    else
      redirect to "/login"
    end
  end

  get '/users/:id' do
    if logged_in?
      @user = current_user
      erb :"/users/show"
    else
      redirect to "/login"
    end
  end
end
