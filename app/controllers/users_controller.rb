class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect "/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    if params.values.any? &:empty?
      redirect "/signup"
    else
<<<<<<< HEAD
      @user = User.find_by(username: params[:username], email: params[:email])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect "/tweets"
        else
          @user = User.create(params)
          session[:user_id] = @user.id
          redirect "/tweets"
        end
=======
      @user = User.find_by(username: params[:username], email: params[:email], password_digest: params[:password]) || @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
>>>>>>> 0e9b6ef9bc5cfb864bbf5ddea00771d426dd4615
    end

  end

  get '/login' do
<<<<<<< HEAD
    if session[:user_id].empty?
      erb :'/users/login'
    else
=======
    if Helpers.logged_in?(session)
      redirect "/tweets"
    else
      erb :'/users/login'
    end
>>>>>>> 0e9b6ef9bc5cfb864bbf5ddea00771d426dd4615
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :"/users/show"
  end




end
