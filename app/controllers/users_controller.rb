class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"users/create_user"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"users/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

  get '/users/show' do
    current_user
    erb :"users/show"
  end

  get '/logout' do
    logout!
    redirect '/login'
  end

  post '/login' do
    login(params[:username], params[:password])
  end

  post '/signup' do
    @user = User.new
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save
      login(params[:username], params[:password])
    else
      redirect '/signup'
    end
  end

end
