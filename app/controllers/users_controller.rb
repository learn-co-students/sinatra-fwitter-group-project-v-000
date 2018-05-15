class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do
    !logged_in? ? (erb :'/users/create_user') : (redirect '/tweets')
  end

  post '/signup' do
    if !logged_in?
      if params[:username] == "" || params[:password] == "" || params[:email] == ""
        redirect '/signup'
      else
        @user = User.create(username: params[:username], password: params[:password], email: params[:email])
        session[:user_id] = @user_id
        redirect '/tweets'
      end
    else
      redirect '/signup'
    end
  end

  get '/login' do
    (!logged_in?) ? (erb :"/users/login") : (redirect "/tweets")
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

end
