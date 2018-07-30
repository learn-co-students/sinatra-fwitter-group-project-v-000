
class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/create_user"
    end
  end

  post "/signup" do
    @new_user = User.new(username: params[:username], email: params[:email], password: params[:password])

    unique_username = User.all.all? do |user|
       @new_user.username != user.username
    end

    if unique_username && @new_user.save
      session[:user_id] = @new_user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end

  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect '/tweets'
      else
          redirect '/login'
      end
    end

    get '/logout' do
      session.clear
      redirect "/login"
    end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :"users/show"
    end

end
