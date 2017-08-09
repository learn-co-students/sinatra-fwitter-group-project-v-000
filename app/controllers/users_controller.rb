require 'pry'

class UsersController < ApplicationController

  get '/' do
    erb :home
  end

  get '/signup' do
    # binding.pry
    if session[:user_id]   #logged_in? doesn't work - because there can still be a session???
      redirect to '/tweets'

    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id

      redirect to '/tweets'
    end
  end
  #





  # User show page, shows tweets
  get '/users/:slug' do
    @user = User.find_by(params[:slug])
    erb :'users/show'

  end


  get '/login' do
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :login
    end
  end

  # form action is '/login' !!!! not '/tweets'

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])   # authentication method 
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if session[:user_id]
      logout!  #helper method
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end
