class UserController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do
    if User.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :signup
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    end
    @user = User.create(username:params[:username], email:params[:email], password:params[:password])
    session[:user_id] = @user.id
    puts session[:user_id]
    redirect to '/tweets'
  end

  get '/login' do
    if User.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      #if username or password is wrong
      redirect to '/login'
    end
    redirect to '/tweets'
  end

  get '/logout' do
    if !User.is_logged_in?(session)
      redirect to '/'
    end
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end