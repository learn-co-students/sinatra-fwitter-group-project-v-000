class UsersController < ApplicationController

  get '/users/:id' do
      @user = User.find_by(id: params[:slug])
      erb :'users/show'
  end



   get '/signup' do
      if !logged_in?
        erb :'users/create_user'
      else
        redirect to '/tweets/tweets'
      end
    end

    post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
    @user.save
    session[:user_id] = @user.id
    redirect '/tweets'
    else
      redirect to '/signup'
    end
  end

   get '/login' do
     if logged_in?
       redirect '/tweets/tweets'
     else
       erb :'users/login'
     end
   end

   post '/login' do
     @user = User.find_by(:username => params[:username])
     if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect :'/tweets'
     else
       redirect '/login'
     end
   end

   get '/users/:id' do
     @user = User.find_by(id: params[:id])
     erb :'users/show'
   end

   get '/logout' do
     if logged_in?
       session.clear
       redirect '/login'
     else
       redirect '/'
     end
   end

end
