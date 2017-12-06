class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'users/create_user'
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
    else
        redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
