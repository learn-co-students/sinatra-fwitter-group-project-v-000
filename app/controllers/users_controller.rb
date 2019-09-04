class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    if !valid_params? #params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
	  else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
	  end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    login
  end

  get '/logout' do
    logout!
  end

  get '/users/:slug' do
    if current_user.username.slugify == params[:slug]
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    else
      redirect "/tweets"
    end
  end

end
