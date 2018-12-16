class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
     erb :'/users/create_user'
   else
    redirect to '/tweets'
    end
  end


  get '/login' do
    erb :'/users/login'
  end

  post '/signup' do
    if params[:password] == "" || params[:email] == "" || params[:username] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

  post '/login' do
      @user = User.find_by(username: params[:username])
      if @user.password == params[:password]
        session[:user_id] = @user.id
        redirect to "/tweets"
      else
        redirect to "/login"
      end

  end

end
