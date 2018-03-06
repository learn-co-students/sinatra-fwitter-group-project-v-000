class UsersController < ApplicationController
get '/signup' do
#  binding.pry
   if logged_in?
    redirect '/tweets' 
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])   
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
     redirect '/signup'
    else
      @user.save
      session[:user_id] = @user.id 
      redirect '/tweets'   
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets' 
    else
      erb :'users/login'
    end
  end

  post '/login' do
    #  binding.pry
    @user = User.find_by(username: params[:username]) 
    if !!@user.authenticate(params[:password]) 
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'     
    end
  end

  get '/users/:slug' do
    
    @user = User.find_by_slug(params[:slug])
    # binding.pry
    erb :'/users/show'
  end
end