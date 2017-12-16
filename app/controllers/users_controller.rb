class UsersController < ApplicationController

  get '/users/:slug' do
    @user =  User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'/users/show'
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if !complete_info_signup?
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
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
    user = User.find_by(username: params[:username])
    if !complete_info_login? && !user.authenticate
      redirect to '/signup'
    else
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end

  get '/logout' do
    if !logged_in?
      redirect '/login'
    else
      logout
      redirect '/login'
    end
  end
end
