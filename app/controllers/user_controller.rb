require './config/environment'

class UserController < ApplicationController


  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect to '/tweets'
    end
  end


  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
        redirect '/signup'
    end
  end


  post '/login' do
    #binding.pry
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :user_show
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end



end
