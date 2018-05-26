class UserController < ApplicationController
      get '/signup' do
      redirect '/tweets' if logged_in?
      erb :'users/create_user'
  end
  
  get '/logout' do
    if logged_in?
      log_out
      redirect '/login'
    else
      redirect '/'
    end
  end
  
  post '/signup' do
    if !!User.new(username: params[:username], email: params[:email], password: params[:password]).save
        session[:user_id] = User.last.id
        redirect '/tweets' 
    else
        redirect '/signup'
    end
  end
  
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect :'/tweets'
    end
  end
  
  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
  
  get '/users/:slug' do
    @current_user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
  
end