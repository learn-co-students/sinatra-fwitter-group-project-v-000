class UsersController < ApplicationController

  get '/signup' do
    # binding.pry
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    #binding.pry
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      # binding.pry

      redirect to "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    # binding.pry
     if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect to "/tweets"
     else
       redirect "/login"
     end
  end

  get '/logout' do
    #binding.pry
    session.clear
    redirect "/login"
  end

end
