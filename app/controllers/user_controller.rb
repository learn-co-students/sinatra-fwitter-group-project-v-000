class UserController < ApplicationController

  #           ////////// SIGNUP //////////////

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/user/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  #           ////////// LOGIN //////////////

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/user/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  #           ////////// LOGOUT //////////////

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  #           ////////// SHOW USER //////////////
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'user/show'
  end

end
