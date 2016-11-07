class UsersController < ApplicationController

  get '/users/:slug' do
    @user= User.find_by_slug(params[:slug])
    erb :'users/show_user'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post "/signup" do
    if logged_in?
      redirect '/tweets'
    else
      user = User.new(params)
  		if user.save
        session[:user_id] = user.id
          redirect "/tweets"
      else
        redirect '/signup'
      end
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect "/tweets"
    end
  end

  post "/login" do
    if logged_in?
      redirect "/tweets"
    else
    user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
      else
        redirect "/login"
      end
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end
end
