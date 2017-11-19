class UserController < ApplicationController

############ SIGNUP ###########
  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:id] = user.id
      redirect to '/tweets'
    end
    redirect to '/users/signup'
  end

############ LOGIN ###########
  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
    redirect to '/tweets'
    end
    redirect to '/signup'
  end

############ SHOW USER ###########
  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

############ LOGOUT ###########
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    end
    redirect to '/'
  end

end
