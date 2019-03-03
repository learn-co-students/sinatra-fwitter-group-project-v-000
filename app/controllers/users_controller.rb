class UsersController < ApplicationController

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.create(params)
    #raise params.inspect
    session[:user_id] = @user.id # actually logging the user in
    redirect "/tweets"
  end

  get '/signup' do
    @user = User.create(username: params[:username], password: params[:password])
    if !@user
        erb :signup
      #binding.pry
    else
      redirect "/tweets"
    end

  end

  post '/signup' do
    #binding.pry
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      # create a new user
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"

    else
      redirect '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
