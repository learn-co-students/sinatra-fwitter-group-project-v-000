class UsersController < ApplicationController
  get '/' do
    erb :index
  end


  get '/login' do
    if logged_in?
      redirect to '/tweets'
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
    redirect "/login"
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
     if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
       @user = User.create(username: params[:username], email: params[:email], password: params[:password])
       session[:user_id] = @user.id
       redirect to "/tweets"
     else
       redirect to "/signup"
     end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to "/login"
    else
      redirect to "/"
    end
  end

  get '/users/:slug' do
    @user = current_user
    erb :'/users/show'
  end

end
