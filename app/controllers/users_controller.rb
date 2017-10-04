class UsersController < ApplicationController
  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    params.each do |key, val|
      if val == ""
        redirect to '/signup'
      end
    end
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect to '/tweets'
  end

  get '/login' do
     if session[:user_id]
       redirect to '/tweets'
     else
       erb :'users/login'  
     end
  end

  post "/login" do
     @user = User.find_by(username: params[:username])
     if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect to '/tweets'
     else
       erb :'users/login'
     end
  end
  
   get '/logout' do
     if logged_in?
       session.clear
       redirect to '/login'
     else
     redirect to '/'
     end
   end
  
   get '/users/:slug' do
     @user = User.find_by_slug(params[:slug])
     erb :'/users/show'
   end


end