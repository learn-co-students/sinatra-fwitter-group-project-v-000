class UsersController < ApplicationController

  get '/signup' do
    if session[:id]
      redirect '/tweets'
    else
      erb :'/users/new'
    end
  end

  post '/signup' do
    @user = User.create(params)

    if @user.save
      flash[:notice] = "Successfully created new user."
      session[:id] = @user.id

      redirect '/tweets'
    else
      flash[:error] = @user.errors.full_messages

      redirect '/signup'
    end
  end

  get '/login' do
    if session[:id]
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(params)

    if @user
      flash[:notice] = "Logged in as #{@user.username}."
      session[:id] = @user.id

      redirect '/tweets'
    else
      flash[:error] = "Incorrect username and/or password."

      redirect '/login'
    end
  end

  get '/logout' do
    if session[:id]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.all.detect{|u| u.slug == params[:slug]}

    erb :'/users/show'
  end

end
