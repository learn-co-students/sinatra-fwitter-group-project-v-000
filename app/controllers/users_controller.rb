class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect to '/tweets'
    end
  end

  # try inserting flash[:message] here and on signup page
  # refer to sinatra playlister

  post "/signup" do
    user = User.create(params)
    session[:user_id] = user.id
    if user.save
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    logout
    redirect to '/login'
  end
end
