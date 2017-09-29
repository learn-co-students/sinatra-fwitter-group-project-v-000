class UserController < ApplicationController

  get '/signup' do 
    if !session[:id]
      erb :'/users/create_user'
    else
      redirect :'/tweets'
    end
  end

  post '/signup' do 
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:id] = @user.id

      redirect :'/tweets'
    end
  end

  get '/login' do 
    if !session[:id]
      erb :'users/login'
    else
      redirect :'/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect :'/tweets'
    else
      redirect :'/signup'
    end
  end

  get '/logout' do 
    if session[:id] != nil
      session.destroy
      redirect :'/login'
    else
      redirect :'/'
    end
  end

  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end

