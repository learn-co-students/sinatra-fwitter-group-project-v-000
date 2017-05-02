class UserController < ApplicationController


get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end
  

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect to "/signup"
    else
      @user = User.create(username: params["username"], password: params["password"], email: params["email"])

      session[:user_id] = @user.id

      redirect to "/tweets"
    end

  end

  get '/login' do 
  	if logged_in?
      redirect to '/tweets'
      else
        erb :'/users/login'
      end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user
      session[:user_id] = @user.id
      redirect '/tweets'
    end
    redirect '/login'
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
    erb :'users/show'
  end

end