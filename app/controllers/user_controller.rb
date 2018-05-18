require './config/environment'

class UserController < ApplicationController
  get '/login' do
    if !!session[:user_id]
      @user = User.find_by_id(session[:user_id])
      redirect to "/users/#{@user.slug}/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if !!@user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect to '/login'
      #flash message?
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user}.slug/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    #TODO:   do not duplicate users ?
    @new_user = User.create(params)
    if !!@new_user.id
      session[:user_id] = @new_user.id
      redirect to "/users/#{@new_user.slug}/tweets"
    else
      #TODO: Flash message here?
      redirect '/signup'
    end
  end

  get '/users/:slug/tweets' do
    #maybe this is an issue because I'm finding by slug, not session_id
    #use helper methods maybe
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

end
