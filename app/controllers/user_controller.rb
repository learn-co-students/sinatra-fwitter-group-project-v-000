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
    erb :'users/login'
  end

  post "/users/login" do #where do we want this to go??
     @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        redirect "/signup"
      end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/"
    else
      redirect "/users/login"
    end
  end

end
