class UsersController < ApplicationController

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user] = @user
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    else
      erb :signup
    end
  end

  post '/signup' do
    if (params["username"].size == 0 || params["email"].size == 0 || params["password"].size == 0)
        redirect '/signup'
    else
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      session[:user] = @user
      session[:id] = @user.id
      redirect "/tweets"
    end
  end

  get '/users/:slug' do
    erb :'users/show_user_tweets'
  end

end
