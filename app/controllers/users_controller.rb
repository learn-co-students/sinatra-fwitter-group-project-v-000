class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.new(:username => params[:username], password => params[:password])
      @user.save
      session[user_id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
  end

  get '/logout' do
  end


end
