require './config/environment'

class UserController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect to '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username].blank? || params[:email].blank? || params[:password].blank?

      redirect :'/signup'
    else
      user = User.new(params)
      user.save
      session[:user_id] = user.id

      redirect :'/tweets'
    end

    erb :index
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    if params[:username].blank? && params[:password].blank?
      erb :'users/login'
    else
      user = User.find_by(:username => params[:username])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id

        redirect "/tweets"
      else
        erb :'users/login'
      end
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'/users/show'
  end

  get '/logout' do
    session.clear

    redirect :'/login'
  end
end
