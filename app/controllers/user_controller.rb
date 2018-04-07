class UserController < ApplicationController

  get '/signup' do
    if logged_in? == false
    erb :'/users/create_user'
  else
    redirect to '/tweets'
  end
  end

  post '/signup' do
      user = User.new(username: params[:username], password: params[:password], email: params[:email])
        if user.valid? && logged_in? == false
          user.save
          session[:user_id] = user.id
          redirect to '/tweets'
      else
          redirect to '/signup'
      end
    end

  get '/login' do
    if logged_in? == false
    erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post "/users/login" do
     @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect to '/signup'
      end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect to '/'
    else
      redirect to '/login'
    end
  end

end
