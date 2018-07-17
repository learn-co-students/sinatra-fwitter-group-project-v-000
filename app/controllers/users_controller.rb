require './config/environment'

class UsersController < ApplicationController

  get '/users/:slug' do
    @current_user = User.find_by_slug(params[:slug])

    erb :'/users/show'
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :'/registrations/signup'
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      user = User.new(params)
      user.save

      session[:user_id] = user.id

      redirect to '/tweets'
    end

    redirect to '/signup'
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/sessions/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    session.clear

    redirect '/login'
  end

end
