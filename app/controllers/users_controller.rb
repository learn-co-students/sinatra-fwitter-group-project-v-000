class UsersController < ApplicationController

  get '/signup' do
    if !!session[:user_id]
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save && user.username != "" && user.email != "" && user.password != ""
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect "/users/#{User.find(session[:user_id]).slug}/tweets"
    else
      erb :'/users/login'
    end
  end


  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.destroy
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find(session[:user_id])
    if logged_in?
      erb :'/users/show'
    else
      redirect '/login'
    end
  end


end
