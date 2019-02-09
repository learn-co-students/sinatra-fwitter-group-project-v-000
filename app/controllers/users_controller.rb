class UsersController < ApplicationController

  get '/users/:slug' do

    @user = User.find_by_slug(params[:slug])
    #binding.pry
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do

    if params[:password] != "" && params[:username] != "" && params[:email] != ""
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      #@tweets = user.tweets
      redirect '/tweets'
    end
  end

  get '/logout' do
    if logged_in?
      #binding.pry
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end

  end



end
