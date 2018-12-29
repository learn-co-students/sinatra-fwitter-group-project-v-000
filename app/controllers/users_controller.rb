class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do
    if is_loggedin?
      redirect to "/tweets"
    else
      erb :"/users/create_user"
    end
  end

  get '/login' do
    if is_loggedin?
      redirect to "/tweets"
    else
      erb :"users/login"
    end
  end

  post '/signup' do
    if params.collect {|k,v| v.strip == ""}.include?(true)
      redirect to "/users/signup"
    else
      user = User.create(params)
      session[:id] = user.id
      redirect to "/tweets"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if is_loggedin?
      redirect to "/tweets"
    elsif !!user && !!user.authenticate(params[:password])
      session[:id] = user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    logout
    redirect to "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

end
