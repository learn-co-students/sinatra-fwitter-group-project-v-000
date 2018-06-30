class UsersController < ApplicationController

  get '/signup' do
    if Helper.new.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save && !user.username.empty? && !user.password.empty? && !user.email.empty?
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if Helper.new.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if Helper.new.is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:user_slug' do
    @user = User.find_by_slug(params[:user_slug])
    erb :'users/show'
  end

end
