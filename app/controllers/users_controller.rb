class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/logout' do
    redirect to '/login'
  end
  
  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  post '/signup' do
    username = params[:username] 
    email = params[:email]
    password = params[:password]
    if username.empty? || email.empty? || password.empty?
         redirect to '/signup'
    else
      user = User.new(username:username, email:email, password:password)
      if user.save
        session[:user_id] = user.id
        @session = session
        
        redirect to '/tweets'
      else
        redirect to '/signup'
      end
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/show_tweet'
  end
  
end
