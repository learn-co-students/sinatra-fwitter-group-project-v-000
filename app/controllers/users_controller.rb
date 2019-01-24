class UsersController < ApplicationController

  get '/signup' do
    if is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    #binding.pry
    if !params.has_value?("")
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if is_logged_in?(session)
      redirect '/tweets'
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      erb :"users/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

  get '/logout' do
    if is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
