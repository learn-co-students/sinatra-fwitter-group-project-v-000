class UsersController < ApplicationController

  get '/users/:user' do
    @user = User.find_by_slug(params[:user])
    @tweets = @user.tweets
    erb :"users/show"
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :signup
  end

  post '/signup' do
      if params[:email] == "" || params[:username] == "" || params[:password] == ""
        redirect to '/signup'
      else
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        session[:user_id] = @user.id
      end
      redirect to '/tweets'
  end



  get '/login' do
    if logged_in?
      redirect to '/tweets'
    end
      erb :"/users/login"
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/tweets'
    end
  end
end
