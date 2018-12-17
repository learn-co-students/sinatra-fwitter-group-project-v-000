class UsersController < ApplicationController

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect "/signup"
      else
        @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        @user.save
        login(@user.id)
        redirect "/tweets"
      end
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    if @user = User.find_by(:username => params[:username])
      if @user.authenticate(params[:password])
        login(@user.id)
        redirect "/tweets"
      else
        redirect "/signup"
      end
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

private
  def login(id)
    session[:user_id] = id
  end
end
