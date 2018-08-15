require_relative '../models/concerns/slugifiable.rb'

class UsersController < ApplicationController

 get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if !params["email"].empty? && !params["username"].empty? && !params["password"].empty?
      @user = User.create(email: params["email"], username: params["username"], password: params["password"])
      session["user_id"] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session["user_id"] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
     @user = User.find_by_slug(params[:slug])
     if !@user.empty?
       redirect to '/tweets'
     else
       redirect to '/'
     end
  end

end
