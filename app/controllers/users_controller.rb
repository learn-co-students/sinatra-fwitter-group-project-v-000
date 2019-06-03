class UsersController < ApplicationController

  get '/users/:slug' do
    #if Helpers.logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    #else
    #  redirect '/'
    #end
  end

  get '/signup' do
    if !Helpers.logged_in?(session)
      erb :'users/new'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if !params[:user][:username].empty? && !params[:user][:password].empty? && !params[:user][:email].empty?
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if !Helpers.logged_in?(session)
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
