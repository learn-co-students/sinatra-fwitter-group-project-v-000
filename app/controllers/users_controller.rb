class UsersController < ApplicationController

#-------- User signup, login, logout --------

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    else
    erb :'users/create_user'
    end
  end

  post "/signup" do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
		if user.save
      session[:user_id] = user.id
        redirect '/tweets'
    elsif !Helpers.logged_in?(session)
        redirect '/signup'
    end
  end

  get '/login' do
    if !Helpers.logged_in?(session)
      erb :'users/login'
    else
      redirect "/tweets"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user= User.find_by_slug(params[:slug])
    erb :'users/show_user'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end
end
